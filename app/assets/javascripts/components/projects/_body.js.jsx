var Body = React.createClass({
  getInitialState() {
    return { projects: [] }
  },

  componentDidMount() {
    $.getJSON(`/api/v1/projects.json`, (response) => { this.setState({ projects: response }) });
  },

  handleSubmit(project) {
    var newState = this.state.projects.concat(project);
    this.setState({ projects: newState })
  },

  handleDelete(id) {
    $.ajax({
      url: `/api/v1/projects/${id}`,
      type: 'DELETE',
      success: () => {
        this.removeProjectClient(id);
      }
    });
  },

  removeProjectClient(id) {
    var newProjects = this.state.projects.filter((project) => {
      return project.id != id;
    });
    this.setState({ projects: newProjects });
  },

  handleUpdate(project) {
    $.ajax({
      url: `/api/v1/projects/${project.id}`,
      type: 'PUT',
      data: { project: project},
      success: () => {
        this.updateProjects(project);
      }
    });
  },

  updateProjects(project) {
    var projects = this.state.projects.filter((i) => { return i.id != project.id });
    projects.push(project);
    this.setState({projects: projects });
  },

  render() {
    return (
      <div>
        <NewProject handleSubmit={this.handleSubmit} />
        <AllProjects projects={this.state.projects} handleDelete={this.handleDelete} onUpdate={this.handleUpdate} />
      </div>
    )
  }
});
