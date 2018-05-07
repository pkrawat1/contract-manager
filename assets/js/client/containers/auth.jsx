import React, { Component } from "react";
import { Container, Row, Col, Button, Form, FormGroup, Label, Input, FormText } from 'reactstrap';
import Login from "../components/login";
import SignUp from "../components/sign_up";
import axios from "axios";

class Auth extends Component {
  componentDidMount() {
    console.log(localStorage.getItem("jwt"));
  }

  registerUser(params) {
    console.log(params);
  }

  login(params) {
    console.log(params);
  }

  render() {
    return (
      <Container>
        <Row className="mt-5 pt-5">
          <Col><SignUp submitClicked={this.registerUser.bind(this)} /></Col>
          <Col className="border-left"><Login submitClicked={this.login.bind(this)} /></Col>
        </Row>
      </Container>
    )
  }
}

export default Auth;
