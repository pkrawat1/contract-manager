import React, { Component } from "react";
import { Button } from 'reactstrap';
import { Header } from "./layout";
import Auth from "./containers/auth";
import Contracts from "./containers/contracts";
import axios from "axios";

class App extends Component {
  constructor(props) {
    super(props);

    this.state = {
      isAuthenticated: false
    };
  }

  onAuthenticated(status) {
    this.setState({ isAuthenticated: status });
    console.log(status);
  }

  logout(event) {
    event.preventDefault();
    axios.defaults.headers.common['Authorization'] = null;
    localStorage.removeItem("authorization");
    this.setState({ isAuthenticated: false });
  }

  renderContractList() {
    if (this.state.isAuthenticated) {
      return <Contracts></Contracts>
    } else {
      return <Auth authenticated={this.onAuthenticated.bind(this)} />
    }
  }

  render() {
    return (
      <div className="app">
        <Header logout={this.logout.bind(this)} isAuthenticated={this.state.isAuthenticated} />
        {this.renderContractList()}
      </div>
    )
  }
}

export default App;
