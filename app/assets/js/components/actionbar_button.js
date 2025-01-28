const actionbarButton = function (eventName) {
  return {
    confirmed: false,

    handleClick(event) {
      if (this.confirmed) {
        this.$dispatch(eventName);
        this.confirmed = false;
      } else {
        event.preventDefault();
        this.confirmed = true;
      }
    },

    root: {
      ["@click"](event) {
        this.handleClick(event);
      },
      ["@click.outside"]() {
        this.confirmed = false;
      },
    },
  };
};

export { actionbarButton };
