import React, { Component } from "react";
import { Button } from 'reactstrap';
import { Footer, Header } from "./layout";
import Auth from "./containers/auth";

class App extends Component {
  render() {
    return (
      <div className="app">
        <Header />
        <Auth />
        <Footer />
      </div>
    )
  }
}

export default App;
