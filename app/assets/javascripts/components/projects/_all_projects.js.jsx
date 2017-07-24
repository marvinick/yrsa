var AllProjects = React.createClass({
  handleDelete(id) {
    this.props.handleDelete(id);
  },

  onUpdate(project) {
    this.props.onUpdate(project);
  },

  render() {
    var projects = this.props.projects.map((project) => {
      return (
        <div key={project.id}>
          <Project project={project} handleDelete={this.handleDelete.bind(this, project.id)} handleUpdate={this.onUpdate} />

        </div>
      )
    });

    return (
      <div>
        <h1>{projects}</h1>
      </div>
    )
  }
});
