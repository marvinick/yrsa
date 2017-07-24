var AllProjects = React.createClass({
  getInitialState() {
    return { projects: [] }
  },

  componentDidMount() {
    console.log('Component mounted');
    $.getJSON(`/api/v1/projects.json`, (response) => { this.setState({ projects: response }) });
  },

  render() {
    var projects = this.state.projects.map((project) => {
      return (
        <div key={project.id}>
          <h3>{project.title}</h3>
          <h5>{project.description}</h5>
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
