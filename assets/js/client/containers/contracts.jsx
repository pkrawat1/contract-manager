import React, { Component } from "react";
import { Container, Button, Row, Col, ListGroup, ListGroupItem, Table } from 'reactstrap';
import axios from "axios";
import Moment from 'react-moment';

class Contracts extends Component {
  constructor(props) {
    super(props);

    this.state = {
      contractList: []
    };

    this.getContractList = this.getContractList.bind(this);
  }

  componentWillMount() {
    this.getContractList();
  }

  getContractList() {
    axios.get("/api/v1/contracts")
      .then(response => this.setState({ contractList: response.data.data }))
      .catch(error => console.log(error));
  }

  renderContractList() {
    return this.state.contractList.map(item =>
      <ListGroupItem key={item.id}>
        <Table>
          <tbody>
            <tr>
              <th>Vendor</th>
              <th>Category</th>
              <th>Costs</th>
              <th>Ends On</th>
            </tr>
            <tr>
              <td>{item.vendor}</td>
              <td>{item.category}</td>
              <td>{item.costs}</td>
              <td><Moment format="MMM DD, YYYY">{item.ends_on}</Moment></td>
            </tr>
          </tbody>
        </Table>
      </ListGroupItem>
    );
  }

  render() {
    return (
      <Container className="pt-5">
        <Row>
          <Col sm="12" md={{ size: 8, offset: 2 }}>
            <h4 className="text-center">
              My Contracts <br />
              <Button className="mt-3">Add Contract</Button>
            </h4>
            <ListGroup className="contract-list mt-3">
              {this.renderContractList()}
            </ListGroup>
          </Col>
        </Row>
      </Container>
    )
  }
}

export default Contracts;
