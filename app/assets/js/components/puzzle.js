const puzzle = function (args) {
  return {
    entries: args.entries,
    activeEntryId: args.entries[0].id,

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
