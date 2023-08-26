import React, { useState, useEffect } from 'react';
import ReactFlow from 'reactflow';
import StepNode from './nodes/StepNode.jsx';
import TaskNode from './nodes/TaskNode.jsx';

const nodeTypes = { Step: StepNode, Task: TaskNode };

export const RoadmapViewer = ({ roadmapId }) => {
  const [nodes, setNodes] = useState([]);
  const [edges, setEdges] = useState([]);
  const [graphHeight, setGraphHeight] = useState(500);

  useEffect(() => {
    renderRoadmap();
  }, []);

  const renderRoadmap = () => {
    fetch(`/admin/roadmaps/${roadmapId}.json`, {
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

  useEffect(() => {
    const totalHeight = nodes.reduce((maxY, node) => Math.max(maxY, node.position.y), 0);
    setGraphHeight(totalHeight + 100); // Adding some extra space for padding
  }, [nodes]);

  return (
    <div className='wrapper' style={{ height: `${graphHeight}px` }}>
      <ReactFlow
        nodes={nodes}
        edges={edges}
        nodeTypes={nodeTypes}
        preventScrolling={false}
        zoomOnScroll={false}
        nodesConnectable={false}
        style={{ height: `${graphHeight}px` }}
        panOnDrag={false}
        nodesDraggable={false}
      >
      </ReactFlow>
    </div>
  );
};

