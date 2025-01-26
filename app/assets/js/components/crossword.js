const crossword = () => {
  return {
    cells: [],
    activeCell: null,
    activeEntryId: null,

    init() {
      this.$nextTick(() => {
        const cellEls = Array.from(this.$root.querySelectorAll("[x-data^='crosswordCell']"));
        this.cells = cellEls.map((cell) => Alpine.$data(cell));
      });
    },

    makeActiveCell(cell) {
      this.activeCell = cell;
      this.updateActiveEntry();
    },

    isActiveCell(cell) {
      return this.activeCell?.id === cell.id;
    },

    isHighlighted(cell) {
      return this.entryCells.find((entryCell) => entryCell.id === cell.id);
    },

    updateActiveEntry() {
      for (let i = 0; i < this.activeCell.entries.length; i++) {
        const entryId = this.activeCell.entries[i];
        if (this.activeEntryId !== entryId) {
          this.activeEntryId = entryId;
          break;
        }
      }
    },

    handleInput(key) {
      if (key.length === 1 && key.match(/[a-z]/i)) {
        this.activeCell.setText(key);
        this.goToNextCell();
      }
    },

    clearCell() {
      if (this.activeCell.isFilled) {
        this.activeCell.clear();
      } else {
        this.goToPreviousCell();
      }
    },

    goToNextCell() {
      const next = this.nextCell;
      if (next) {
        this.activeCell = next;
      }
    },

    goToPreviousCell() {
      const previous = this.previousCell;
      if (previous) {
        this.activeCell = previous;
      }
    },

    get previousCell() {
      const index = this.activeCellEntryIndex;

      if (index === 0) {
        return null;
      } else {
        return this.entryCells[index - 1];
      }
    },

    get nextCell() {
      const entryCells = this.entryCells;
      const index = this.activeCellEntryIndex;

      if (index === entryCells.length - 1) {
        return null;
      } else {
        return entryCells[index + 1];
      }
    },

    get activeCellEntryIndex() {
      return this.entryCells.findIndex((entry) => entry.id === this.activeCell.id);
    },

    get entryCells() {
      return this.cells.filter((cell) => cell.entries.includes(this.activeEntryId));
    },
  };
};

const crosswordCell = (args) => {
  return {
    entries: args.entries || [],

    setText(text) {
      this.$refs.text.textContent = text.toUpperCase();
    },

    clear() {
      this.setText("");
    },

    get text() {
      return this.$refs.text.textContent;
    },

    get isEmpty() {
      return this.text === "";
    },

    get isFilled() {
      return !this.isEmpty;
    },

    get id() {
      return this.$root.id;
    },

    get active() {
      return this.crossword.isActiveCell(this);
    },

    set active(value) {
      this.crossword.makeActiveCell(value ? this : null);
    },

    get highlighted() {
      return this.crossword.isHighlighted(this);
    },

    get crossword() {
      return Alpine.$data(this.$root.closest("[x-data='crossword']"));
    },
  };
};

export { crossword, crosswordCell };
