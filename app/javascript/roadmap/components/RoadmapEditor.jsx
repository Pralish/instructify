import React, { useState, useEffect, useCallback, useRef } from 'react';
import ReactFlow, {
  Controls,
  Background,
  BackgroundVariant,
  useNodesState,
  useEdgesState,
  useReactFlow,
  addEdge,
  ReactFlowProvider,
} from 'reactflow';
import StepNode from './nodes/StepNode.jsx';
import { formDataToJson, formatedPayload } from '../../utils.js';
import TaskNode from './nodes/TaskNode.jsx';
import FloatingEdge from './edges/FloatingEdge.jsx';
import ButtonEdge from './edges/ButtonEdge.jsx';

const nodeTypes = { Step: StepNode, Task: TaskNode };
const edgeTypes = { floating: FloatingEdge, button: ButtonEdge };

const RoadmapEditor = ({ roadmapId }) => {
  const [rfInstance, setRfInstance] = useState(null);
  const [nodes, setNodes, onNodesChange] = useNodesState([]);
  const [edges, setEdges, onEdgesChange] = useEdgesState([]);
  const [graphHeight, setGraphHeight] = useState(500);

  const reactFlowWrapper = useRef(null);
  const connectingNodeId = useRef({});

  const { project } = useReactFlow();

  const onConnect = useCallback((params) => setEdges((eds) => addEdge(params, eds)), []);

  const onConnectStart = useCallback((_, { nodeId, handleId }) => {
    connectingNodeId.current = { nodeId, handleId };
  }, []);


  const onConnectEnd = useCallback(
    (event) => {
      const targetIsPane = event.target.classList.contains('react-flow__pane');

      if (targetIsPane) {
        // we need to remove the wrapper bounds, in order to get the correct position
        const { top, left } = reactFlowWrapper.current.getBoundingClientRect();
        const position = project({ x: event.clientX - left - 75, y: event.clientY - top });
        
        const payload = {
          task: {
            type: 'Task',
            title: 'New Task',
            parent_id: connectingNodeId.current.nodeId,
            position: position,
            incoming_edges_attributes: [{
              source_id: connectingNodeId.current.nodeId,
              source_handle: connectingNodeId.current.handleId,
              target_handle: connectingNodeId.current.handleId.includes('left') ? 'right' : 'left',
            }]
          }
        }
        buildNode(`/admin/roadmaps/${roadmapId}/nodes.json`, payload, 'POST');
      }
    },
    [project]
  );

  useEffect(() => {
    renderRoadmap();
  }, []);

  useEffect(() => {
    const handleModalFormSubmitted = (event) => {
      console.log(event)
      const formData = formDataToJson(new FormData(event.detail.event.srcElement))
      console.log(formData)
      buildNode(`${event.detail.event.srcElement.action}.json`, formData, formData._method?.toUpperCase() || 'POST')
      event.detail.offcanvasOutlet.hideOffcanvas();
    };

    document.addEventListener('modalFormSubmitted', handleModalFormSubmitted);

    return () => {
      document.removeEventListener('modalFormSubmitted', handleModalFormSubmitted);
    };
  }, []);

  const buildNode = async (url, body, method) => {
    await fetch(url, {
      method: method,
      body: JSON.stringify(body),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.head.querySelector(`meta[name="csrf-token"]`).getAttribute('content')
        }
      })
      .then(response => response.json())
      .then(response => {

      // setNodes((nds) => nds.concat(response.data.node))
      // setEdges((nds) => nds.concat(response.data.edge))
      // TODO: only add new node from response instead of fetching all nodes
      // TODO: update parent node so that, add icon is not shown
      renderRoadmap();
    })
  }

  // TODO: onSave getting triggered even when links are clicked on nodes 
  const onSave = useCallback(() => {
    if (rfInstance) {
      fetch(`/admin/roadmaps/${roadmapId}.json`, {
        method: 'PATCH',
        body: JSON.stringify(formatedPayload(rfInstance.toObject())),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.head.querySelector(`meta[name="csrf-token"]`).getAttribute('content')
      }})
      .then(response => response.json())
      .then(data => {
        console.log(data)
      })
      .catch(error => console.error('Error fetching data:', error));
    }
  }, [rfInstance]);

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

  // const deleteNode = () => {
  //   fetch('/admin/roadmaps/1.json', {
  //     method: 'DELETE',
  //     headers: {
  //       'Accept': 'application/json',
  //       'Content-Type': 'application/json'
  //   }})
  //   .then(response => response.json())
  //   .then(data => {

  //     })
  //     .catch(error => console.error('Error fetching data:', error));
  // }

  useEffect(() => {
    const totalHeight = nodes.reduce((maxY, node) => Math.max(maxY, node.position.y), 0);
    setGraphHeight(totalHeight + 100); // Adding some extra space for padding
  }, [nodes]);

  return (
    <div className='wrapper' ref={reactFlowWrapper} style={{ height: '100%' }}>
      <ReactFlow
        nodes={nodes}
        edges={edges}
        onNodesChange={onNodesChange}
        onEdgesChange={onEdgesChange}
        onConnect={onConnect}
        onConnectStart={onConnectStart}
        onConnectEnd={onConnectEnd}
        onInit={setRfInstance}
        nodeTypes={nodeTypes}
        edgeTypes={edgeTypes}
        preventScrolling={false}
        onNodeDragStop={onSave}
        zoomOnScroll="false"
      >
        <Controls />
        <Background id="grid-small" className="react-flow__background-small" gap={10} color="#f1f1f1" variant={BackgroundVariant.Lines} />
        <Background id="grid-large" className="react-flow__background-large" gap={100} offset={1} color="#ccc" variant={BackgroundVariant.Lines} />
      </ReactFlow>
    </div>
  );
};

export default ({roadmapId}) => (
  <ReactFlowProvider>
    <RoadmapEditor roadmapId={roadmapId}/>
  </ReactFlowProvider>
);

