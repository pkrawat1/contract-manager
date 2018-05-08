import React, { Component } from "react";
import { Container, Row, Col, Button, Form, FormGroup, Label, Input, FormText } from 'reactstrap';
import Login from "../components/login";
import SignUp from "../components/sign_up";
import axios from "axios";

class Auth extends Component {
  constructor(props) {
    super(props);

    this.state = {
      sessionError: null,
      registrationError: null
    };
  }

  componentDidMount() {
    const authorization = localStorage.getItem("authorization")
    this.updateAxiosAuthHeader(authorization);
    this.props.authenticated(!!authorization);
  }

  setAuthenticated(jwt) {
    const authorization = `Bearer: ${jwt}`
    localStorage.setItem("authorization", authorization);
    this.updateAxiosAuthHeader(authorization);
    this.props.authenticated(!!authorization);
  }

  updateAxiosAuthHeader(authorization) {
    axios.defaults.headers.common['Authorization'] = authorization;
  }

  registerUser(registration) {
    axios.post("/api/v1/registrations", { registration })
      .then(response => this.setAuthenticated(response.data.jwt))
      .catch(error => this.setState({ registrationError: error.response.data.errors }));
  }

  login(session) {
    axios.post("/api/v1/sessions", { session })
      .then(response => this.setAuthenticated(response.data.jwt))
      .catch(error => this.setState({ sessionError: error.response.data.error }));
  }

  render() {
    console.log(this.state)
    return (
      <Container>
        <Row className="mt-5 pt-5">
          <Col><SignUp error={this.state.registrationError} submitClicked={this.registerUser.bind(this)} /></Col>
          <Col className="border-left"><Login error={this.state.sessionError} submitClicked={this.login.bind(this)} /></Col>
        </Row>
      </Container>
    )
  }
}

export default Auth;
