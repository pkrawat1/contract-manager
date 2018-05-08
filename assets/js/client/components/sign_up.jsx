import React, { Component } from "react";
import { FormFeedback, Button, Form, FormGroup, Label, Input, FormText } from 'reactstrap';

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
    const error = this.props.error || {};

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
            onChange={this.handleChange.bind(this)}
            invalid={!!error.full_name}
          />
          <FormFeedback>{error.full_name ? error.full_name[0] : ""}</FormFeedback>
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
            invalid={!!error.email}
          />
          <FormFeedback>{error.email ? error.email[0] : ""}</FormFeedback>
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
            invalid={!!error.password}
          />
          <FormFeedback>{error.password ? error.password[0] : ""}</FormFeedback>
        </FormGroup>
        <FormGroup>
          <Label for="SignUpConfirmPassword">Confirm Password</Label>
          <Input
            type="password"
            name="password_confirmation"
            id="SignUpConfirmPassword"
            placeholder="xxxxxxx"
            value={this.state.password_confirmation}
            onChange={this.handleChange.bind(this)}
            invalid={!!error.password_confirmation}
          />
          <FormFeedback>{error.password_confirmation ? error.password_confirmation[0] : ""}</FormFeedback>
        </FormGroup>
        <Button>Submit</Button>
      </Form>
    )
  }
}

export default SignUp;
