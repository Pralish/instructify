import { Controller } from "@hotwired/stimulus"
import React from "react";
import ReactDOM from "react-dom/client";

import { RoadmapViewer } from "../roadmap/components/RoadmapViewer";
import RoadmapEditor from "../roadmap/components/RoadmapEditor";

// Connects to data-controller="roadmap-renderer"
export default class extends Controller {
  initialize() {
    this.roadmapId = this.element.dataset.roadmapId
    this.action = this.element.dataset.action
  }

  connect() {
    const root = ReactDOM.createRoot(this.element);
    if (this.action == 'edit') {
      root.render(<RoadmapEditor roadmapId={ this.roadmapId } />)
    } else {
      root.render(<RoadmapViewer roadmapId={ this.roadmapId } />)
    }
  }
}
