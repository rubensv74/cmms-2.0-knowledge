# CMMS Lab — First-use DVP brief v2

**Status:** revised candidates for functional/visual review; no Studio evidence  
**Users:** Hernando and Eduardo, as walkthrough participants only  
**Source:** CMMS Proposal v12 (30/10/2026), pp. 3 and 6–7  
**Data:** deterministic functional synthetic profile v1.1; no production records.

## Walkthrough goal

A first-time user should understand the relationship between the Approved Maintenance Plan, an annual preventive Work Order, its planned actions, and the linked execution results. They should recognize that a scheduled/planned action has no actual result yet.

## The two screens

1. **Work Queue — Annual PM view.** Shows annual preventive orders only, with asset/activity/plan, explicit cycle, action counts, next scheduled time and parent status. The profile cards are data-description totals, not operational KPIs: 62 orders, 248 actions, 124 executions and 124 actions not completed. Search and filter the annual queue; open a row.
2. **Annual Work Order Detail.** Shows asset and synthetic plan provenance, each **actuación preventiva programada**, planned due date, schedule and state. Selecting an executed action displays its ExecutionRecord inline. Back returns with queue context retained.

The queue no longer presents a corrective row that cannot be opened in this slice. Export and the separate execution-record button are removed. Corrective and CBM cases remain in the synthetic pack for later DVP capabilities.

## Ayuda contextual y decisiones

Cada pantalla ofrece un modal **How it works** con el propósito, los controles y límites disponibles y las decisiones que explican el diseño. La ayuda distingue la descripción AS-IS de la reunión del 21/08, los principios confirmados el 25/09 y el baseline posterior de DEC-025/propuesta 30/10, que sigue pendiente de ratificación TR. Abrir o cerrar el modal no cambia ni pierde el contexto. Véase el [contrato del modal](screen-help-and-decision-rationale-modal-v1.md).

## Scenarios

- Primary order: `LAB-PM-2026-00004`, four planned actions; two executions recorded; one action scheduled for 20 November 2026; one remains planned.
- Cycle-end scenario: three completed and one pending action, no disposition selected. It demonstrates the distinction; it does not define policy.
- All assets, plan names, dates, cycle labels, metrics, personnel and results are synthetic.

## Visual target revisions

- [Work Queue v2](targets/work-queue-v2-candidate.svg)
- [Annual Order Detail v2](targets/annual-order-detail-v2-candidate.svg)
- [Work Queue help-open state](targets/work-queue-help-open-v1-candidate.svg)
- [Annual Order Detail help-open state](targets/annual-order-detail-help-open-v1-candidate.svg)

Both retain the accepted visual direction: premium industrial photo header, shared shell, clear screen purpose, compact queue and HERO detail. These are candidate target assets, not Canvas renders. The exact v2 target revisions need to be pinned in the readiness ledger before PaYaml.

## Walkthrough checks

1. Find the annual order without assistance.
2. Explain what the parent order represents.
3. Distinguish the planned due date, scheduled slot, and actual execution dates.
4. Identify the two executed actions and the two not-completed actions.
5. Return to the queue without losing its current context.
6. Explain which controls are demo-only and which business rules remain open.

A successful walkthrough validates comprehension of the demo only; it does not approve business policy, permissions, SQL, flows, or runtime behavior.
