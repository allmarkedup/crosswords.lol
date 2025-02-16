export default function Button() {
  return {
    confirming: false,

    handleClick(event, handler = null) {
      if (!this.confirmable || this.confirming) {
        if (handler) handler();
        this.reset();
      } else {
        event.preventDefault();
        this.confirming = true;
      }
    },

    reset() {
      this.confirming = false;
    },

    get ready() {
      return !this.confirmable || !this.confirming;
    },

    get confirmable() {
      return !!this.$refs.confirmation;
    },
  };
}
