var NewProject = React.createClass({
  handleClick() {
    var title = this.refs.title.value;
    var description = this.refs.description.value;
    $.ajax({
      url: `/api/v1/projects`,
      type: `POST`,
      data: { project: { title: title, description: description } },
      success: (project) => {
        this.props.handleSubmit(project);
      }
    });
  },

  render () {
    return (
      <div>
        <input ref="title" placeholder="Enter the title" />
        <input ref="description" placeholder="Description" />
        <button onClick={this.handleClick} className="btn right">Submit</button>
      </div>
    )
  }
});
