import React, { Component } from "react";
import { Button } from 'reactstrap';
import { Footer, Header } from "./layout";

class App extends Component {
  render() {
    return (
      <div className="app">
        <Header />
        <Footer />
      </div>
    )
  }
}

export default App;
