import React from 'react';
import { Handle, Position } from 'reactflow';

export default function TaskNode({ data, isConnectable }) {
  const baseUrl = `/admin/roadmaps/${data.roadmap_id}/nodes`

  return (
    <div className='roadmap__node roadmap__node-task'>
      <Handle type="target" position={Position.Top} isConnectable={isConnectable}/>
      <div className="roadmap__title--md text-center">{data.title}</div>
      {isConnectable &&
        <div className="d-flex actions position-absolute gap-2">
          <a data-turbo-frame="modal" href={`${baseUrl}/${data.id}/edit`}>
            <i className="bi bi-pencil-square" cursorshover="true"></i>
          </a>
          <a data-turbo-method="delete" data-turbo-confirm="Are you sure?" rel="nofollow" data-method="delete" href={`${baseUrl}/${data.id}`}>
            <i className="bi bi-trash"></i>
          </a>
        </div>
      }
      <Handle type="source" position={Position.Bottom} isConnectable={isConnectable}/>
      <Handle type="target" position={Position.Left} id="left-target" isConnectable={isConnectable}/>
      <Handle type="target" position={Position.Right} id="right-target" isConnectable={isConnectable}/>
      <Handle type="source" position={Position.Left} id="left-source" isConnectable={isConnectable}/>
      <Handle type="source" position={Position.Right} id="right-source" isConnectable={isConnectable}/>
    </div>
  );
}