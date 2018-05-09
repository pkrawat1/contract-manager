import React, { Component } from "react";
import {
  Collapse,
  Navbar,
  NavbarToggler,
  NavbarBrand,
  Nav,
  NavItem,
  NavLink,
  UncontrolledDropdown,
  DropdownToggle,
  DropdownMenu,
  DropdownItem
} from 'reactstrap';
import axios from "axios";

export default class Header extends Component {
  constructor(props) {
    super(props);

    this.toggle = this.toggle.bind(this);
    this.state = {
      isOpen: false
    };
  }

  toggle() {
    this.setState({
      isOpen: !this.state.isOpen
    });
  }

  renderLogoutDropdown() {
    if (!this.props.isAuthenticated) { return }
    return (<NavLink style={{cursor: "pointer"}} onClick={(event) => this.props.logout(event)}>Logout</NavLink>)
  }

  render() {
    return (
      <div>
        <Navbar className="shadow-sm bg-white" light expand="md">
          <div className="container">
            <NavbarBrand href="/"><img src="/images/logo.png" width="52" height="30" className="d-inline-block align-top" alt="" />Contract Manager</NavbarBrand>
            <NavbarToggler onClick={this.toggle} />
            <Collapse isOpen={this.state.isOpen} navbar>
              <Nav className="ml-auto" navbar>
                <NavItem>
                  {this.renderLogoutDropdown()}
                </NavItem>
              </Nav>
            </Collapse>
          </div>
        </Navbar>
      </div>
    );
  }
}
