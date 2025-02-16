const confettiCount = 200;
const confettiDefaults = {
  spread: 70,
  angle: -90,
  origin: { x: 0.5, y: -0.2 },
  shapes: ["emoji", "image"],
  shapeOptions: {
    emoji: {
      value: ["🦄", "🌈", "⭐️"],
      particles: {
        size: {
          value: 8,
        },
      },
    },
    image: [
      {
        src: RAILS_ASSET_URL("icon.svg"),
        width: 32,
        height: 32,
        particles: {
          size: {
            value: 10,
          },
        },
      },
    ],
  },
};

function fireConfettiBurst(particleRatio, opts) {
  window.confetti(
    Object.assign({}, confettiDefaults, opts, {
      particleCount: Math.floor(confettiCount * particleRatio),
    })
  );
}

function fireConfetti() {
  fireConfettiBurst(0.25, {
    spread: 26,
    startVelocity: 55,
  });

  fireConfettiBurst(0.2, {
    spread: 60,
  });

  fireConfettiBurst(0.35, {
    spread: 100,
    decay: 0.91,
    scalar: 0.8,
  });

  fireConfettiBurst(0.1, {
    spread: 120,
    startVelocity: 25,
    decay: 0.92,
    scalar: 1.2,
  });

  fireConfettiBurst(0.1, {
    spread: 120,
    startVelocity: 45,
  });
}

export { fireConfettiBurst, fireConfetti };
