import { tsParticles } from "@tsparticles/engine";
import { loadConfettiPreset } from "@tsparticles/preset-confetti";
import { loadEmojiShape } from "@tsparticles/shape-emoji";
import { loadImageShape } from "@tsparticles/shape-image";

const puzzle = function (args) {
  return {
    entries: args.entries,
    activeEntryId: args.entries[0].id,

    async init() {
      await loadConfettiPreset(tsParticles);
      await loadEmojiShape(tsParticles);
      await loadImageShape(tsParticles);
    },

    async showConfetti() {
      return tsParticles.load({
        id: "confetti",
        options: {
          emitters: {
            startCount: 150,
            position: {
              x: 50,
              y: 0,
            },
            size: {
              width: 0,
              height: 0,
            },
            rate: {
              delay: 10,
              quantity: 0,
            },
            life: {
              duration: 0.1,
              count: 1,
            },
          },
          particles: {
            shape: {
              type: ["image", "emoji"],
              options: {
                emoji: {
                  particles: {
                    size: {
                      value: 10,
                    },
                  },
                  value: ["🦄", "⭐️", "🌈", "🧩"],
                },
                image: [
                  {
                    src: RAILS_ASSET_URL("icon.svg"),
                    width: 32,
                    height: 32,
                    particles: {
                      size: {
                        value: 14,
                      },
                    },
                  },
                ],
              },
            },
          },
          preset: "confetti",
        },
      });
    },

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
