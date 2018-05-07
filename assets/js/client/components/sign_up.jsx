import React, { Component } from "react";
import { Button, Form, FormGroup, Label, Input, FormText } from 'reactstrap';

class SignUp extends Component {
  constructor(props) {
    super(props);

    this.state = {
      full_name: "",
      email: "",
      password: "",
      confirm_password: ""
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
    return (
      <Form onSubmit={this.handleSubmit.bind(this)}>
        <legend>New User!</legend>
        <small>Let's help you get started</small>
        <hr />
        <FormGroup>
          <Label for="SignUpFullName">Full Name</Label>
          <Input
            type="text"
            name="full_name"
            id="SignUpFullName"
            placeholder="Enter full name"
            value={this.state.full_name}
            onChange={this.handleChange.bind(this)} />
        </FormGroup>
        <FormGroup>
          <Label for="SignUpEmail">Email</Label>
          <Input
            type="email"
            name="email"
            id="SignUpEmail"
            placeholder="example@123.com"
            value={this.state.email}
            onChange={this.handleChange.bind(this)}
          />
        </FormGroup>
        <FormGroup inline>
          <Label for="SignUpPassword">Password</Label>
          <Input
            type="password"
            name="password"
            id="SignUpPassword"
            placeholder="xxxxxxx"
            value={this.state.password}
            onChange={this.handleChange.bind(this)}
          />
        </FormGroup>
        <FormGroup>
          <Label for="SignUpConfirmPassword">Confirm Password</Label>
          <Input
            type="password"
            name="confirm_password"
            id="SignUpConfirmPassword"
            placeholder="xxxxxxx"
            value={this.state.confirm_password}
            onChange={this.handleChange.bind(this)}
          />
        </FormGroup>
        <Button>Submit</Button>
      </Form>
    )
  }
}

export default SignUp;
