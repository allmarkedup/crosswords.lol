const actionbarButton = function (eventName) {
  return {
    confirming: false,

    handleClick(event) {
      if (this.confirming) {
        this.$dispatch(eventName);
        this.confirming = false;
        this.confirmationButton = null;
      } else {
        event.preventDefault();
        this.confirming = true;
        this.confirmationButton = this;
      }
    },

    root: {
      ["@click"](event) {
        this.handleClick(event);
      },
      ["@click.outside"]() {
        this.confirming = false;
        this.confirmationButton = null;
      },
      ":class": "{confirming}",
    },
  };
};

export { actionbarButton };
