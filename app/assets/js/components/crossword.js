export default function Crossword() {
  return {
    cells: [],
    complete: false,

    init() {
      this.$nextTick(() => {
        const cellEls = Array.from(this.$el.querySelectorAll("[x-data^='crosswordCell']"));
        this.cells = cellEls.map((cell) => Alpine.$data(cell));
        this.entries.forEach((entry) => {
          entry.cells = this.cells.filter((cell) => cell.parentEntryIds.includes(entry.id));
        });

        if (!this.activeCellId) {
          this.$puzzle.state.activeCellId = this.activeEntry.cells[0].id;
        }

        Alpine.effect(() => this.checkCompleteness());
        if (this.complete) this.$dispatch("crossword:complete", { initial: true });

        this.$watch("complete", (complete) => {
          this.$dispatch(complete ? "crossword:complete" : "crossword:incomplete");
        });
      });

      this.$watch("activeCellId", () => {
        this.activeCell.$el.scrollIntoView({ behavior: "smooth" });
      });

      this.$watch("activeEntryId", (id) => {
        if (!this.activeCell.parentEntryIds.includes(this.activeEntryId)) {
          this.$puzzle.state.activeCellId = this.activeEntry.cells[0].id;
        }
      });
    },

    checkEntry(entry) {
      const incorrectCells = entry.cells.filter((cell) => cell.incorrect);
      incorrectCells.forEach((cell) => cell.check());
    },

    checkActiveEntry() {
      this.$dispatch("event:check-word");
      this.checkEntry(this.activeEntry);
    },

    checkAllEntries() {
      this.$dispatch("event:check-all");
      this.entries.forEach((entry) => this.checkEntry(entry));
    },

    revealActiveCell() {
      if (this.activeCell.empty) {
        this.$dispatch("event:reveal-letter");
      }
      const letters = this.activeEntry.solution.split("");
      this.activeCell.text = letters[this.activeCellEntryIndex];
      this.goToNextCell();
    },

    revealEntry(entry) {
      if (!this.checkEntryCorrect(entry)) {
        this.$dispatch("event:reveal-word");
      }

      const letters = entry.solution.split("");
      for (let i = 0; i < entry.length; i++) {
        entry.cells[i].text = letters[i];
      }
    },

    revealActiveEntry() {
      this.revealEntry(this.activeEntry);
    },

    revealAllEntries() {
      this.entries.forEach((entry) => this.revealEntry(entry));
    },

    clearEntry(entry) {
      entry.cells.forEach((cell) => cell.clear());
    },

    clearActiveEntry() {
      this.clearEntry(this.activeEntry);
    },

    clearAllEntries() {
      this.entries.forEach((entry) => this.clearEntry(entry));
    },

    reset() {
      this.clearAllEntries();
      this.$puzzle.state.activeEntryId = this.entries[0].id;
      this.$puzzle.state.activeCellId = this.entries[0].cells[0].id;
      this.$dispatch("timer:reset");
    },

    checkCompleteness() {
      for (let i = 0; i < this.entries.length; i++) {
        if (!this.checkEntryCorrect(this.entries[i])) {
          this.complete = false;
          return;
        }
      }
      this.complete = true;
    },

    checkEntryCorrect(entry) {
      return entry.cells.filter((cell) => cell.correct).length === entry.cells.length;
    },

    handleInput(key, event) {
      if (key.length === 1 && key.match(/[a-z]/i)) {
        event.stopPropagation();
        event.preventDefault();
        this.$nextTick(() => {
          this.activeCell.text = key;
          this.goToNextCell();
        });
      }
    },

    handleCellNavigation(event) {
      const { key } = event;

      const down = this.activeEntryDirection === "down";
      const across = !down;

      if (
        (["ArrowUp", "ArrowDown"].includes(key) && across) ||
        (["ArrowLeft", "ArrowRight"].includes(key) && down)
      ) {
        this.toggleActiveEntry();
      }

      if ((key === "ArrowDown" && down) || (key === "ArrowRight" && across)) {
        this.goToNextCell();
      } else if ((key === "ArrowUp" && down) || (key === "ArrowLeft" && across)) {
        this.goToPreviousCell();
      }
    },

    handleBackspace() {
      if (this.activeCell.filled) {
        this.activeCell.clear();
      } else {
        this.goToPreviousCell();
      }
    },

    goToNextCell() {
      const index = this.activeCellEntryIndex;
      const nextCell = this.activeEntry.cells[index + 1];
      if (nextCell) nextCell.active = true;
    },

    goToPreviousCell() {
      const index = this.activeCellEntryIndex;
      const previousCell = this.activeEntry.cells[index - 1];
      if (previousCell) previousCell.active = true;
    },

    goToNextEntry(event) {
      if (event) event.stopImmediatePropagation();

      const index = this.activeEntryIndex;
      let nextEntry = null;

      if (index === this.entries.length - 1) {
        nextEntry = this.entries[0];
      } else {
        nextEntry = this.entries[index + 1];
      }

      this.$puzzle.state.activeEntryId = nextEntry.id;
    },

    goToPreviousEntry(event) {
      if (event) event.stopImmediatePropagation();

      const index = this.activeEntryIndex;
      let previousEntry = null;

      if (index === 0) {
        previousEntry = this.entries[this.entries.length - 1];
      } else {
        previousEntry = this.entries[index - 1];
      }

      this.$puzzle.state.activeEntryId = previousEntry.id;
    },

    toggleActiveEntry() {
      for (let i = 0; i < this.activeCell.parentEntryIds.length; i++) {
        if (this.$puzzle.state.activeEntryId !== this.activeCell.parentEntryIds[i]) {
          this.$puzzle.state.activeEntryId = this.activeCell.parentEntryIds[i];
          return;
        }
      }
    },

    get activeEntryIndex() {
      return this.entries.findIndex((entry) => entry.id === this.state.activeEntryId);
    },

    get activeCellEntryIndex() {
      return this.activeEntry.cells.findIndex((entry) => entry.id === this.activeCellId);
    },

    get activeEntryDirection() {
      return this.activeEntryId.includes("down") ? "down" : "across";
    },

    get activeEntryId() {
      return this.$puzzle.state.activeEntryId;
    },

    get activeCellId() {
      return this.$puzzle.state.activeCellId;
    },

    get activeCell() {
      return this.cells.find((cell) => cell.id === this.activeCellId);
    },

    get activeEntry() {
      return this.entries.find((entry) => entry.id === this.activeEntryId);
    },

    get entries() {
      return this.$puzzle.entries;
    },
  };
}
