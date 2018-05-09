import React, { Component } from "react";
import { ListGroupItem, Table, Button, Form, FormGroup, Label, Input, FormText, FormFeedback } from 'reactstrap';
import Moment from 'react-moment';
import axios from "axios";
import moment from 'moment';

class ContractForm extends Component {
  constructor(props) {
    super(props);

    this.state = {
      id: '',
      vendor_id: "",
      category_id: "",
      ends_on: "",
      costs: "",
      vendors: [],
      errors: {}
    };
  }

  componentWillMount() {
    this.loadVendors();

    const contract = this.props.contract;

    if (contract) {
      this.setState({
        vendor_id: contract.vendor_id,
        category_id: contract.category_id,
        ends_on: moment(contract.ends_on, "YYYY-MM-DD").format("MMM DD, YYYY"),
        costs: contract.costs,
        id: contract.id
      });
    }
  }

  loadVendors() {
    axios.get("/api/v1/vendors")
      .then(res => this.setState({ vendors: res.data.data }))
      .catch(error => console.log(error));
  }

  renderVendorList() {
    return this.state
      .vendors.map(vendor =>
        <option key={vendor.id} value={vendor.id}>
          {vendor.name}
        </option>
      );
  }

  renderCategoryList() {
    const selectedVendor = this.state.vendors.find(vendor =>
      vendor.id == this.state.vendor_id
    );

    if (!selectedVendor) { return }

    return selectedVendor.categories.map(category =>
      <option key={category.id} value={category.id}>
        {category.name}
      </option>
    );
  }

  handleChange({ target }) {
    this.setState({
      [target.name]: target.value
    });
  }

  handleSubmit(event) {
    event.preventDefault();

    const { id, vendor_id, category_id, costs } = this.state;    
    const ends_on = moment(this.state.ends_on, "MMM DD, YYYY").format();
    const contract = { id, ends_on, vendor_id, category_id, costs };

    const params = contract.id ? { id: contract.id, contract } : { contract }

    axios({
      method: contract.id ? 'put' : 'post',
      url: `/api/v1/contracts/${contract.id}`,
      data: params
    })
      .then(res => this.props.contractSubmitted())
      .catch(error =>
        this.setState(
          Object.assign(this.state, {
            errors: error.response && error.response.data.errors
          })
        )
      );
  }

  render() {
    const error = this.state.errors || {};

    return (
      <Form className="card shadow-sm p-5 col-md-8 offset-md-2 align-center" onSubmit={this.handleSubmit.bind(this)}>
        <legend>{this.props.contract ? "Edit Contract" : "New Contract"}</legend>
        <hr />
        <FormGroup>
          <Label for="vendor_id">Vendor</Label>
          <Input
            type="select"
            name="vendor_id"
            id="vendor_id"
            onChange={this.handleChange.bind(this)}
            invalid={!!error.vendor_id}
            value={this.state.vendor_id}>
            <option disabled>Select Vendor</option>
            {this.renderVendorList()}
          </Input>
          <FormFeedback>{error.vendor_id ? error.vendor_id[0] : ""}</FormFeedback>
        </FormGroup>
        <FormGroup>
          <Label for="category_id">Category</Label>
          <Input
            type="select"
            name="category_id"
            id="category_id"
            onChange={this.handleChange.bind(this)}
            invalid={!!error.category_id}
            value={this.state.category_id}>
            <option disabled>Select Category</option>
            {this.renderCategoryList()}
          </Input>
          <FormFeedback>{error.category_id ? error.category_id[0] : ""}</FormFeedback>
        </FormGroup>
        <FormGroup>
          <Label for="costs">Costs</Label>
          <Input
            autoFocus
            type="text"
            name="costs"
            id="costs"
            placeholder="eg: 12.4"
            value={this.state.costs}
            onChange={this.handleChange.bind(this)}
            invalid={!!error.costs}
          />
          <FormFeedback>{error.costs ? error.costs[0] : ""}</FormFeedback>
        </FormGroup>
        <FormGroup>
          <Label for="ends_on">Ends On</Label>
          <Input
            autoFocus
            type="text"
            name="ends_on"
            id="ends_on"
            placeholder="eg: Aug 19, 2019"
            value={this.state.ends_on}
            onChange={this.handleChange.bind(this)}
            invalid={!!error.ends_on}
          />
          <FormFeedback>{error.ends_on ? error.ends_on[0] : ""}</FormFeedback>
        </FormGroup>
        <Button className="mt-3 btn-info border-0">Submit</Button>
      </Form>
    )
  }
}

export default ContractForm;
