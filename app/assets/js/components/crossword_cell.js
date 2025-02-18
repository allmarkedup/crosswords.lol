export default function CrosswordCell(args) {
  return {
    id: null,
    parentEntryIds: args.parentEntryIds || [],

    init() {
      this.id = this.$el.id;
    },

    clear() {
      this.text = "";
    },

    get text() {
      return (this.$puzzle.state.values[this.id] || "").toUpperCase();
    },

    set text(str) {
      this.$puzzle.state.values[this.id] = str.toUpperCase();
    },

    get active() {
      return this.$puzzle.state.activeCellId === this.id;
    },

    set active(value) {
      const wasActive = this.active;
      const wasHighlighted = this.highlighted;

      this.$puzzle.state.activeCellId = this.id;

      if (wasActive) {
        for (let i = 0; i < this.parentEntryIds.length; i++) {
          if (this.$puzzle.state.activeEntryId !== this.parentEntryIds[i]) {
            this.$puzzle.state.activeEntryId = this.parentEntryIds[i];
            return;
          }
        }
      } else if (!wasHighlighted) {
        for (let i = 0; i < this.parentEntryIds.length; i++) {
          const entry = this.entries.find((entry) => entry.id === this.parentEntryIds[i]);
          if (entry.cells[0].id === this.id) {
            this.$puzzle.state.activeEntryId = entry.id;
            return;
          }
        }
        this.$puzzle.state.activeEntryId = this.parentEntryIds[0];
      }
    },

    get highlighted() {
      return this.parentEntryIds.includes(this.$puzzle.state.activeEntryId);
    },

    get empty() {
      return this.text === "";
    },

    get filled() {
      return !this.empty;
    },
  };
}
