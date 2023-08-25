import React from 'react';
import { Handle, Position } from 'reactflow';

export default function StepNode({ data, isConnectable }) {
  const baseUrl = `/admin/roadmaps/${data.roadmap_id}/nodes`

  console.log({isConnectable})
  return (
    <div className='roadmap__node roadmap__node-step'>
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
        {!data.has_children && isConnectable &&
          <a data-turbo-frame="modal" className='add-new position-absolute d-flex justify-content-center' href={`${baseUrl}/new?parent_id=${data.id}`}>
            <i className="bi bi-plus-square" cursorshover="true"></i>
          </a>
        }
    
      <Handle type="source" position={Position.Bottom} isConnectable={isConnectable}/>
      <Handle type="source" position={Position.Left} id="left" isConnectable={isConnectable}/>
      <Handle type="source" position={Position.Right} id="right" isConnectable={isConnectable}/>
    </div>
  );
}