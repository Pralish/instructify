import React, { useState, useEffect } from 'react';
import ReactFlow, { Controls } from 'reactflow';
import StepNode from './nodes/StepNode.jsx';
import TaskNode from './nodes/TaskNode.jsx';

const nodeTypes = { Step: StepNode, Task: TaskNode };

export const RoadmapViewer = ({ roadmapId }) => {
  const [nodes, setNodes] = useState([]);
  const [edges, setEdges] = useState([]);

  useEffect(() => { renderRoadmap() }, []);

  const renderRoadmap = () => {
    fetch(`/roadmaps/${roadmapId}.json`, {
      method: 'GET',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
    }})
    .then(response => response.json())
    .then(data => {
        const nodes = data.data.attributes.nodes
        const edges = data.data.attributes.edges
        setNodes(nodes);
        setEdges(edges);
      })
      .catch(error => console.error('Error fetching data:', error));
  }

  return (
    <ReactFlow
      nodes={nodes}
      edges={edges}
      nodeTypes={nodeTypes}
      preventScrolling={false}
      zoomOnScroll={false}
      nodesConnectable={false}
      panOnDrag={false}
      nodesDraggable={false}
      fitView
    >
    </ReactFlow>
  );
};

