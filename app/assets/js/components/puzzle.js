const confettiCount = 200;
const confettiDefaults = {
  spread: 70,
  angle: -90,
  origin: { x: 0.5, y: 0 },
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

function fireConfetti(particleRatio, opts) {
  window.confetti(
    Object.assign({}, confettiDefaults, opts, {
      particleCount: Math.floor(confettiCount * particleRatio),
    })
  );
}

const puzzle = function (args) {
  return {
    entries: args.entries,
    activeEntryId: args.entries[0].id,

    showConfetti() {
      fireConfetti(0.25, {
        spread: 26,
        startVelocity: 55,
      });

      fireConfetti(0.2, {
        spread: 60,
      });

      fireConfetti(0.35, {
        spread: 100,
        decay: 0.91,
        scalar: 0.8,
      });

      fireConfetti(0.1, {
        spread: 120,
        startVelocity: 25,
        decay: 0.92,
        scalar: 1.2,
      });

      fireConfetti(0.1, {
        spread: 120,
        startVelocity: 45,
      });
    },
    //   return tsParticles.load({
    //     id: "confetti",
    //     options: {
    //       emitters: {
    //         startCount: 150,
    //         position: {
    //           x: 50,
    //           y: 0,
    //         },
    //         size: {
    //           width: 0,
    //           height: 0,
    //         },
    //         rate: {
    //           delay: 10,
    //           quantity: 0,
    //         },
    //         life: {
    //           duration: 0.1,
    //           count: 1,
    //         },
    //       },
    //       particles: {
    //         shape: {
    //           type: ["image", "emoji"],
    //           options: {
    //             emoji: {
    //               particles: {
    //                 size: {
    //                   value: 10,
    //                 },
    //               },
    //               value: ["🦄", "⭐️", "🌈", "🧩"],
    //             },
    //             image: [
    //               {
    //                 src: RAILS_ASSET_URL("icon.svg"),
    //                 width: 32,
    //                 height: 32,
    //                 particles: {
    //                   size: {
    //                     value: 14,
    //                   },
    //                 },
    //               },
    //             ],
    //           },
    //         },
    //       },
    //       preset: "confetti",
    //     },
    //   });
    // },

    get activeEntry() {
      if (!this.activeEntryId) return null;

      return this.entries.find((entry) => entry.id === this.activeEntryId);
    },

    get activeEntryIndex() {
      return this.entries.findIndex((entry) => entry.id === this.activeEntryId);
    },

    get nextEntry() {
      const index = this.activeEntryIndex;
      if (index === this.entries.length - 1) {
        return this.entries[0];
      } else {
        return this.entries[index + 1];
      }
    },

    get previousEntry() {
      const index = this.activeEntryIndex;
      if (index === 0) {
        return this.entries[this.entries.length - 1];
      } else {
        return this.entries[index - 1];
      }
    },
  };
};

export { puzzle };
