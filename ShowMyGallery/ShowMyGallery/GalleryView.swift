//
//  GalleryView.swift
//  ShowMyGallery
//
//  Created by Hira Shrestha on 17/09/2026.

//  A full-screen photo gallery where the user picks the transition
//  animation used to move to the next/previous photo.
//
//  Requires iOS 16+ (PhotosPicker). Drop this file into an Xcode project
//  and show `GalleryView()` from your app, e.g. as the root view.
//

import SwiftUI
import PhotosUI

// MARK: - Transition styles

enum GalleryTransition: String, CaseIterable, Identifiable {
    case fade   = "Fade"
    case slide  = "Slide"
    case zoom   = "Zoom"
    case flip   = "Flip"

    var id: String { rawValue }

    /// The SwiftUI transition to apply for the *incoming* image,
    /// given the direction of travel (true = next, false = previous).
    func transition(forward: Bool) -> AnyTransition {
        switch self {
        case .fade:
            return .opacity.animation(.easeInOut(duration: 0.35))

        case .slide:
            let insertion: Edge = forward ? .trailing : .leading
            let removal: Edge = forward ? .leading : .trailing
            return .asymmetric(
                insertion: .move(edge: insertion),
                removal: .move(edge: removal)
            )

        case .zoom:
            return .asymmetric(
                insertion: .scale(scale: 1.15).combined(with: .opacity),
                removal: .scale(scale: 0.9).combined(with: .opacity)
            )

        case .flip:
            return .modifier(
                active: FlipModifier(angle: forward ? 90 : -90),
                identity: FlipModifier(angle: 0)
            )
        }
    }

    /// The animation curve/duration paired with this style.
    var animation: Animation {
        switch self {
        case .fade:  return .easeInOut(duration: 0.35)
        case .slide: return .interpolatingSpring(stiffness: 260, damping: 28)
        case .zoom:  return .easeInOut(duration: 0.35)
        case .flip:  return .easeInOut(duration: 0.45)
        }
    }
}

/// Custom 3D flip effect used by `.flip`.
private struct FlipModifier: ViewModifier {
    let angle: Double
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(angle),
                axis: (x: 0, y: 1, z: 0),
                perspective: 0.5
            )
            .opacity(angle == 0 ? 1 : 0.3)
    }
}

// MARK: - Main gallery view

struct GalleryView: View {
    @State private var images: [UIImage] = []
    @State private var currentIndex: Int = 0
    @State private var transitionStyle: GalleryTransition = .fade
    @State private var goingForward: Bool = true

    @State private var pickerItems: [PhotosPickerItem] = []

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if images.isEmpty {
                emptyState
            } else {
                stage
                overlayUI
            }
        }
        .onChange(of: pickerItems) { _ in loadPickedImages() }
    }

    // MARK: Stage (the current photo, full screen, letterboxed)

    private var stage: some View {
        GeometryReader { geo in
            ZStack {
                Image(uiImage: images[currentIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .id(currentIndex) // forces the transition to run on change
                    .transition(transitionStyle.transition(forward: goingForward))

                // Invisible tap zones for prev / next
                HStack(spacing: 0) {
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture { advance(forward: false) }
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture { advance(forward: true) }
                }
            }
        }
        .gesture(
            DragGesture(minimumDistance: 40)
                .onEnded { value in
                    if value.translation.width < 0 {
                        advance(forward: true)
                    } else if value.translation.width > 0 {
                        advance(forward: false)
                    }
                }
        )
    }

    // MARK: Overlay chrome (counter + transition picker)

    private var overlayUI: some View {
        VStack {
            HStack {
                PhotosPicker(selection: $pickerItems, matching: .images) {
                    Label("Add", systemImage: "plus")
                        .labelStyle(.iconOnly)
                        .padding(10)
                        .background(.ultraThinMaterial, in: Circle())
                }
                Spacer()
                Text("\(currentIndex + 1) / \(images.count)")
                    .font(.system(size: 13, weight: .medium, design: .monospaced))
                    .foregroundStyle(.white.opacity(0.85))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.ultraThinMaterial, in: Capsule())
            }
            .padding()

            Spacer()

            Picker("Transition", selection: $transitionStyle) {
                ForEach(GalleryTransition.allCases) { style in
                    Text(style.rawValue).tag(style)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
        }
    }

    // MARK: Empty state

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 40))
                .foregroundStyle(.white.opacity(0.6))
            Text("Your gallery, full screen")
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white)
            Text("Add a few photos, then pick how they transition to the next.")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.6))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            PhotosPicker(selection: $pickerItems, maxSelectionCount: 20, matching: .images) {
                Text("Choose Photos")
                    .font(.subheadline.weight(.semibold))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(.white.opacity(0.15), in: Capsule())
                    .foregroundStyle(.white)
            }
        }
    }

    // MARK: Logic

    private func advance(forward: Bool) {
        guard images.count > 1 else { return }
        goingForward = forward
        withAnimation(transitionStyle.animation) {
            currentIndex = forward
                ? (currentIndex + 1) % images.count
                : (currentIndex - 1 + images.count) % images.count
        }
    }

    @MainActor
    private func loadPickedImages() {
        Task {
            var loaded: [UIImage] = []
            for item in pickerItems {
                if let data = try? await item.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    loaded.append(uiImage)
                }
            }
                images.append(contentsOf: loaded)
                pickerItems = []
            
        }
    }
}

#Preview {
    GalleryView()
}
