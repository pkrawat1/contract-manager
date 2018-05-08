import React, { Component } from "react";
import { Container, Button, Row, Col, ListGroup } from 'reactstrap';
import axios from "axios";
import ContractListItem from "../components/contract-list-item";
import ContractForm from "../components/contract-form";
import Moment from 'react-moment';


class Contracts extends Component {
  constructor(props) {
    super(props);

    this.state = {
      contractList: [],
      selectedContract: null,
      isFormOpen: false,
      isContractShow: false
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

  selectContract(contract) {
    this.setState(
      Object.assign(
        this.state, {
          selectedContract: contract,
          isContractShow: true
        }
      )
    );
  }

  createNewContract() {
    this.setState(
      Object.assign(
        this.state, {
          isFormOpen: true
        }
      )
    );
  }

  contractListUpdated(contract) {
    console.log(contract);
    this.setState(
      Object.assign(
        this.state, {
          isContractShow: false,
          selectedContract: null,
          isFormOpen: false,
          contractList: [contract, ...this.state.contractList]
        }
      )
    );
  }

  renderContractList() {
    console.log(this.state)
    if (this.state.isContractShow || this.state.isFormOpen) { return }
    return (
      <ListGroup className="contract-list mt-3">
        <h4 className="text-center">
          My Contracts <br />
          <Button className="my-3" onClick={this.createNewContract.bind(this)}>Add Contract</Button>
        </h4>
        {
          this.state
            .contractList
            .map(item =>
              <ContractListItem
                key={item.id}
                contract={item}
                selected={this.selectContract.bind(this)}></ContractListItem>
            )
        }
      </ListGroup>
    );
  }

  renderContractForm() {
    if (!this.state.isFormOpen) { return }
    return <ContractForm contractSubmitted={this.contractListUpdated.bind(this)} contract={this.state.selectedContract}></ContractForm>;
  }

  renderContract() {
    const selectedContract = this.state.selectedContract
    if (!(this.state.isContractShow && selectedContract)) { return }
    return (
      <div>
        <dl>
          <dt>Vendor</dt>
          <dd>{selectedContract.vendor}</dd>
          <dt>Category</dt>
          <dd>{selectedContract.category}</dd>
          <dt>Costs</dt>
          <dd>{selectedContract.costs}</dd>
          <dt>Ends on</dt>
          <dd><Moment format="MMM DD, YYYY">{selectedContract.ends_on}</Moment></dd>
        </dl>
        <h3>
          <Button>Edit</Button>
          <Button>Delete</Button>
        </h3>
      </div>
    )
  }

  render() {
    return (
      <Container className="pt-5">
        <Row>
          <Col sm="12" md={{ size: 8, offset: 2 }}>
            {this.renderContractForm()}
            {this.renderContract()}
            {this.renderContractList()}
          </Col>
        </Row>

      </Container>
    )
  }
}

export default Contracts;
