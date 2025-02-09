const keyboardAction = function (eventNames, confirmable = false) {
  return {
    confirming: false,

    handleClick(event) {
      event.preventDefault();
      event.stopPropagation();
      if (!confirmable || this.confirming) {
        eventNames.forEach((eventName) => this.$dispatch(eventName));
        this.reset();
      } else {
        this.confirming = true;
      }
    },

    reset() {
      this.confirming = false;
    },

    root: {
      ["@click"](event) {
        this.handleClick(event);
      },
      ["@click.outside"]() {
        this.confirming = false;
      },
      ":class": "{confirming}",
    },
  };
};

export { keyboardAction };
