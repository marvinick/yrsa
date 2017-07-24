var Project = React.createClass({
  getInitialState() {
    return {editable: false}
  },

  handleEdit() {
    if(this.state.editable) {
      var title = this.refs.title.value;
      var id = this.props.project.id;
      var description = this.refs.description.value;
      var project = {id: id, title: title, description: description};
      this.props.handleUpdate(project);
    }
    this.setState({editable: !this.state.editable})
  },

  render() {
    var title = this.state.editable ? <input type='text' ref='title' defaultValue={this.props.project.title} /> : <h4>{this.props.project.title}</h4>;
    var description = this.state.editable ? <input type='text' ref='description' defaultValue={this.props.project.description} /> : <p>{this.props.project.description}</p>;

    return (
      <div>
        <h4>{title}</h4>
        <h5>{description}</h5>
        <button onClick={this.props.handleDelete} >Delete</button>
        <button onClick={this.handleEdit}>{this.state.editable ? 'Submit' : 'Edit' }</button>
      </div>
    )
  }
})
