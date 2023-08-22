import React from 'react';
import { Handle, Position } from 'reactflow';

import styled from 'styled-components'


const Node = styled.div`
  display: flex;
  flex-direction: column;
  height: 100%;
  border-width: 1px;
  border-style: solid;
  border-color: #c4cbd1;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: rgba(0, 0, 0, 0.1) 0px 4px 6px -1px, rgba(0, 0, 0, 0.06) 0px 2px 4px -1px;
  width: 150px;
  padding: 20px;
  background: #fff;
  postion: relative;
  font-family: 'JetBrains Mono', monospace;
  align-items: center;
  justify-content: center;

  .actions {
    top: 3px;
    right: 5px;
  }

  .add-new {
    bottom: -80px;
    font-size: 24px;
    background: #fff;

    &::before {
      content: '';
      position: absolute;
      border-left: 1px solid #c4cbd1;
      height: 44px;
      top: -40px;
    }
  }
`

const IconLink = styled.a`

`
export default function StepNode({ data }) {
  const baseUrl = `/admin/roadmaps/${data.roadmap_id}/nodes`

  return (
    <Node>
      <Handle type="target" position={Position.Top} />
      <div className="roadmap__title--md text-center">{data.title}</div>
      <div className="d-flex actions position-absolute gap-2">
        <a data-turbo-frame="modal" href={`${baseUrl}/${data.id}/edit`}>
          <i className="bi bi-pencil-square" cursorshover="true"></i>
        </a>
        <a data-turbo-method="delete" data-turbo-confirm="Are you sure?" rel="nofollow" data-method="delete" href={`${baseUrl}/${data.id}`}>
          <i className="bi bi-trash"></i>
        </a>
      </div>
      {!data.has_children &&
        <a data-turbo-frame="modal" className='add-new position-absolute d-flex justify-content-center' href={`${baseUrl}/new?parent_id=${data.id}`}>
          <i className="bi bi-plus-square" cursorshover="true"></i>
        </a>
      }
      <Handle type="source" position={Position.Bottom}/>
      <Handle type="source" position={Position.Left} id="left" />
      <Handle type="source" position={Position.Right} id="right" />
    </Node>
  );
}