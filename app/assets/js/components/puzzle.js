import { fireConfetti } from "../helpers/confetti";

export default function Puzzle({ id, entries }) {
  let vibeTimer = null;

  return {
    entries: entries,
    $puzzle: null,
    state: null,
    vibing: false,

    init() {
      this.$puzzle = this;
      this.state = this.getState(id);
    },

    getState(id) {
      if (!this.$state.crosswords[id]?.values) {
        this.$state.crosswords[id] = {
          activeEntryId: this.entries[0].id,
          activeCellId: null,
          timer: null,
          values: {},
        };
      }
      return this.$state.crosswords[id];
    },

    celebrate() {
      fireConfetti();
      this.vibing = true;
      vibeTimer = setTimeout(() => {
        this.vibing = false;
      }, 5000);
    },

    destroy() {
      clearTimeout(vibeTimer);
    },
  };
}
