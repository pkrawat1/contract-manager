import React, { Component } from "react";
import { Button, Form, FormGroup, Label, Input, FormText, FormFeedback } from 'reactstrap';

class Login extends Component {
  constructor(props) {
    super(props);

    this.state = {
      email: "",
      password: ""
    };
  }

  handleChange(event) {
    this.setState({
      [event.target.name]: event.target.value
    });
  }

  handleSubmit(event) {
    event.preventDefault();
    this.props.submitClicked(this.state);
  }

  render() {
    const error = this.props.error;

    return (
      <Form onSubmit={this.handleSubmit.bind(this)}>
        <legend>Existing User</legend>
        <small>Let's manage your contracts</small>
        <hr />
        <FormGroup>
          <Label for="loginEmail">Email</Label>
          <Input
            autoFocus
            type="email"
            name="email"
            id="loginEmail"
            placeholder="example@123.com"
            value={this.state.email}
            onChange={this.handleChange.bind(this)}
            invalid={!!error}
          />
          <FormFeedback>{error}</FormFeedback>
        </FormGroup>
        <FormGroup>
          <Label for="LoginPassword">Password</Label>
          <Input
            type="password"
            name="password"
            id="LoginPassword"
            placeholder="xxxxxxx"
            value={this.state.password}
            onChange={this.handleChange.bind(this)}
            invalid={!!error}
          />
          <FormFeedback>{error}</FormFeedback>
        </FormGroup>
        <Button>Submit</Button>
      </Form>
    )
  }
}

export default Login;
