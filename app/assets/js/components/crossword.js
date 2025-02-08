const crossword = function (args) {
  return {
    uuid: args.id,
    cells: [],
    activeCell: null,
    state: null,
    complete: false,

    init() {
      this.state = this.$store.state.getCrosswordState(this.uuid);

      this.$nextTick(() => {
        const cellEls = Array.from(this.$root.querySelectorAll("[x-data^='crosswordCell']"));
        this.cells = cellEls.map((cell) => Alpine.$data(cell));
        this.entries.forEach((entry) => {
          entry.cells = this.cells.filter((cell) => cell.entryIds.includes(entry.id));
        });

        this.activeCell = this.state.activeCellId
          ? this.cells.find((cell) => cell.id === this.state.activeCellId)
          : this.activeEntry.cells[0];
        this.setActiveEntry();

        Alpine.effect(() => this.checkCompleteness());
      });

      this.$watch("activeEntryId", (entryId) => {
        if (!this.activeCell.entryIds.includes(entryId)) {
          this.makeActiveCell(this.activeEntry.cells[0], this.activeEntry.id);
        }
        this.activeCell.$el.scrollIntoView({ behavior: "smooth" });
      });

      this.$watch("complete", (complete) => {
        if (complete) this.$dispatch("complete");
      });
    },

    makeActiveCell(cell, entryId = null) {
      const prevCell = this.activeCell;
      this.activeCell = cell;
      this.state.activeCellId = cell.id;
      if (entryId) {
        this.activeEntryId = entryId;
      } else {
        if (prevCell && prevCell.id === cell.id) {
          this.toggleActiveEntry();
        } else {
          this.setActiveEntry();
        }
      }
    },

    isActiveCell(cell) {
      return this.activeCell?.id === cell.id;
    },

    isInActiveEntry(cell) {
      return this.activeEntryCells.find((entryCell) => entryCell.id === cell.id);
    },

    setActiveEntry() {
      if (!this.activeCell.entryIds.includes(this.activeEntryId)) {
        for (let i = 0; i < this.activeCell.entryIds.length; i++) {
          const entryId = this.activeCell.entryIds[i];
          const entry = this.entries.find((entry) => entry.id === entryId);
          if (entry.cells[0].id === this.activeCell.id) {
            this.activeEntryId = entryId;
            return;
          }
        }
        this.activeEntryId = this.activeCell.entryIds[0];
      }
    },

    toggleActiveEntry() {
      if (!this.activeCell) return;

      for (let i = 0; i < this.activeCell.entryIds.length; i++) {
        const entryId = this.activeCell.entryIds[i];
        if (this.activeEntryId !== entryId) {
          this.activeEntryId = entryId;
          break;
        }
      }
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

    handleNavigation(event) {
      const { key } = event;
      if (key === "Tab") {
        if (event.getModifierState("Shift")) {
          this.goToPreviousEntry();
        } else {
          this.goToNextEntry();
        }
        return;
      }

      if (
        (["ArrowUp", "ArrowDown"].includes(key) && this.entryDirection === "across") ||
        (["ArrowLeft", "ArrowRight"].includes(key) && this.entryDirection === "down")
      ) {
        this.toggleActiveEntry();
      }

      const down = this.entryDirection === "down";
      const across = this.entryDirection === "across";

      if ((key === "ArrowDown" && down) || (key === "ArrowRight" && across)) {
        this.goToNextCell();
      } else if ((key === "ArrowUp" && down) || (key === "ArrowLeft" && across)) {
        this.goToPreviousCell();
      }
    },

    handleBackspace() {
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

    goToNextEntry() {
      this.activeEntryId = this.nextEntry.id;
    },

    goToPreviousEntry() {
      this.activeEntryId = this.previousEntry.id;
    },

    revealActiveCell() {
      const letters = this.activeEntry.solution.split("");
      this.activeCell.text = letters[this.activeCellEntryIndex];
    },

    revealEntry(entry) {
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

    checkEntry(entry) {
      const letters = entry.solution.split("");
      for (let i = 0; i < entry.length; i++) {
        const cell = entry.cells[i];
        if (cell.text !== letters[i]) {
          cell.clear();
        }
      }
    },

    checkActiveEntry() {
      this.checkEntry(this.activeEntry);
    },

    checkAllEntries() {
      this.entries.forEach((entry) => this.checkEntry(entry));
    },

    clearEntry(entry) {
      entry.cells.forEach((cell) => cell.clear());
    },

    clearActiveEntry() {
      this.clearEntry(this.activeEntry);
    },

    clearAllEntries() {
      this.$store.state.crosswords[this.uuid] = { entries: {} };
      this.entries.forEach((entry) => this.clearEntry(entry));
    },

    checkCompleteness() {
      for (let i = 0; i < this.entries.length; i++) {
        const entry = this.entries[i];
        const letters = entry.solution.split("");
        for (let j = 0; j < entry.length; j++) {
          const cell = entry.cells[j];
          if (cell.text !== letters[j]) {
            this.complete = false;
            return;
          }
        }
        this.complete = true;
      }
    },

    get previousCell() {
      const index = this.activeCellEntryIndex;

      if (index === 0) {
        return null;
      } else {
        return this.activeEntryCells[index - 1];
      }
    },

    get nextCell() {
      const entryCells = this.activeEntryCells;
      const index = this.activeCellEntryIndex;

      if (index === entryCells.length - 1) {
        return null;
      } else {
        return entryCells[index + 1];
      }
    },

    get activeCellEntryIndex() {
      return this.activeEntryCells.findIndex((entry) => entry.id === this.activeCell.id);
    },

    get activeEntryCells() {
      return this.activeEntry?.cells || [];
    },

    get entryDirection() {
      if (this.activeCell) {
        return this.activeEntryId.includes("down") ? "down" : "across";
      } else {
        return null;
      }
    },
  };
};

const crosswordCell = (args) => {
  return {
    _text: "",
    entryIds: args.entryIds || [],

    init() {
      this._text = this.state.entries[this.id] || "";

      this.$watch("_text", (char) => {
        this.state.entries[this.id] = char;
      });
    },

    clear() {
      this.text = "";
    },

    get text() {
      return this._text;
    },

    set text(char) {
      this._text = char.toUpperCase();
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
      return this.crossword.isInActiveEntry(this);
    },

    get crossword() {
      return Alpine.$data(this.$root.closest("[x-data^='crossword']"));
    },
  };
};

export { crossword, crosswordCell };
