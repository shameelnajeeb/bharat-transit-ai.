# Product Requirements Document: Bus Tracking AI Agent

**Status:** Draft  
**Version:** 1.0  
**Last updated:** 10 November 2026  
**Audience:** Product, engineering, design, operations, data, and customer support

## 1. Product summary

The Bus Tracking AI Agent helps passengers find a bus, understand when it will arrive, and respond to disruptions. It combines live vehicle and schedule data with a conversational interface. The agent provides concise, source-grounded answers and offers practical next steps when a bus is delayed, rerouted, or missing from live data.

This PRD assumes an initial deployment for a public transit operator with access to route schedules, stop locations, and a real-time vehicle feed. The product should support the operator’s chosen passenger channels, starting with a web or mobile chat experience.

## 2. Problem and opportunity

Passengers often have to check several pages or apps to answer simple questions: where their bus is, whether it is on time, and what to do when service changes. Static timetables do not reflect current conditions, while raw live maps can be hard to interpret. Riders may also lack the route or stop terminology needed to find the right information.

A conversational agent can translate natural-language questions into route and stop lookups, explain live status in plain language, and guide passengers toward a useful alternative. For the operator, it can reduce repetitive information requests and provide a consistent service-information experience.

## 3. Goals

- Help a passenger identify the correct route, stop, and direction with minimal effort.
- Provide accurate, timestamped arrival estimates from authorized transit data.
- Explain uncertainty and data freshness clearly.
- Surface active service alerts that affect the passenger’s trip.
- Offer relevant alternatives when service is disrupted or a vehicle cannot be located.
- Reduce avoidable contacts to human support without blocking escalation.
- Meet accessibility, privacy, reliability, and operational requirements.

## 4. Non-goals

- Dispatching vehicles or changing schedules, routes, or operator instructions.
- Replacing the transit agency’s official service-alert system.
- Guaranteeing an arrival time or a seat, accessibility feature, or connection.
- Booking rides, accepting payments, or issuing refunds in the initial release.
- Providing emergency response services.
- Using facial recognition or identifying individual passengers or drivers.

## 5. Users and use cases

### Primary users

- **Passenger:** Wants to know whether to wait, walk to another stop, or choose another route.
- **Visitor or occasional rider:** Knows a destination but not the local route or stop names.
- **Passenger with accessibility needs:** Needs clear information about accessible stops, vehicles, or service interruptions, where verified data is available.
- **Transit support agent:** Needs to confirm what information the AI gave and take over complex cases.
- **Transit operations staff:** Needs to monitor data quality, answer quality, and service-related demand.

### Core use cases

1. “When is the next 24 bus at Central and 3rd?”
2. “Where is the bus I’m waiting for?”
3. “Is the 8 running normally to the station?”
4. “I’m at the library and need to get to the hospital. What should I take?”
5. “The bus hasn’t moved for 15 minutes. Is there another option?”
6. “Can I take this route with a wheelchair?”—only when the relevant accessibility data is verified.

## 6. Product experience

### Entry and clarification

The passenger can ask in natural language or select a route, stop, and direction. If a query could refer to more than one location, the agent asks a short clarifying question and presents recognizable choices. The agent must not silently choose an ambiguous stop or route.

### Answer format

A standard arrival answer should include:

- Route and direction, when known.
- Stop name and location, when known.
- Estimated arrival time or a clear “schedule only” indication.
- Vehicle status, such as approaching, delayed, or not currently reporting.
- The time the underlying data was last updated.
- A relevant active alert, if one affects the result.
- A concise next step when the estimate is unavailable or service is disrupted.

Example: “The next Route 24 toward Downtown is estimated in 6 minutes at Central St & 3rd Ave. Live position last updated 1 minute ago. A detour is active; the bus will use the temporary stop on 3rd Ave.”

### Trip guidance

For origin-to-destination questions, the agent should gather missing details, present a small number of viable options, and explain transfers and walking segments using approved routing data. It must show assumptions, such as departure time or walking distance, when these materially affect the recommendation.

### Unavailable or stale data

If live data is stale, missing, conflicting, or unavailable, the agent must say so plainly. It may show scheduled times, clearly labeled as scheduled, and point to official alerts or human support. It must never present a schedule time as a live prediction.

### Escalation

The passenger can request a human at any point. The agent should hand off with the route/stop context and a short summary where the channel supports it. If live human support is unavailable, it should provide the official support contact or service page.

## 7. Functional requirements

### P0 — Required for launch

- Accept passenger questions in plain language and identify relevant route, stop, direction, time, and destination entities.
- Search the operator’s approved route, stop, schedule, and service-alert data.
- Retrieve real-time vehicle location and predicted arrival data where available.
- Distinguish live predictions from scheduled times in both wording and presentation.
- Display the source update timestamp and apply a configurable freshness threshold.
- Ask for clarification when entity matching is ambiguous or confidence is below a defined threshold.
- Explain when no vehicle is reporting or an estimate cannot be produced.
- Include applicable service alerts with links to the official notice where possible.
- Provide a human-support path and avoid claiming to have taken an action it did not take.
- Log operational events and quality signals without unnecessarily retaining message content or personal data.

### P1 — Near-term follow-up

- Suggest alternate routes or stops using approved routing and accessibility data.
- Support trip planning across transfers and compare estimated travel times.
- Support multiple languages selected from operator priorities.
- Offer optional arrival notifications with explicit opt-in and an easy opt-out.
- Provide an internal operations view for feed health, unresolved queries, and answer quality.
- Support voice input or output where the target channel and accessibility testing allow it.

### P2 — Later opportunities

- Personalize saved routes and stops with passenger consent.
- Provide disruption summaries for a passenger’s saved trips.
- Use aggregated question trends to help the operator improve passenger information.

## 8. AI behavior and answer policy

- Use retrieval and structured transit data for factual service answers; do not rely on model memory for current schedules, locations, or alerts.
- Treat transit feeds and agency notices as the authority for service facts. The language model may explain those facts but must not invent them.
- Return concise answers first, with optional detail on request.
- State uncertainty when sources disagree or data is incomplete.
- Do not claim certainty about future arrival, service operation, accessibility, or connections beyond what the source supports.
- Do not infer a passenger’s precise location. Use location only when the passenger provides or explicitly shares it, and offer manual entry.
- Keep the conversation focused on transit. For emergencies or immediate safety issues, direct the passenger to local emergency services and the operator’s official contact route; do not imply emergency response capability.
- Maintain a clear distinction between service information and operator decisions. The agent cannot authorize exceptions or promise that a driver will wait.

## 9. Data and integrations

### Required data sources

- Static schedule and route data, preferably GTFS or an equivalent agency feed.
- Real-time vehicle positions and trip updates, preferably GTFS Realtime or an equivalent feed.
- Official service alerts, detours, stop closures, and temporary stop locations.
- Optional routing and accessibility attributes, with provenance and last-updated metadata.

### Integration requirements

- Normalize route, stop, trip, and vehicle identifiers across feeds.
- Track feed ingestion time, source timestamp, and data freshness independently.
- Validate schema and reject malformed updates safely.
- Handle missing feeds and partial outages without taking down the passenger interface.
- Cache stable reference data; keep live data within operator-defined freshness and caching limits.
- Provide a source and timestamp trace for each response for support and audit review.

## 10. Non-functional requirements

- **Availability:** Target 99.9% monthly availability for the passenger-facing service, excluding declared upstream feed outages.
- **Latency:** Target p95 response time under 3 seconds for common arrival queries, excluding slow upstream dependencies; communicate when a lookup takes longer.
- **Freshness:** Make the live-feed freshness threshold configurable by feed and operator. Default behavior should label data older than 2 minutes as potentially stale and suppress live-position claims when it exceeds the operator’s approved limit.
- **Accessibility:** Target WCAG 2.2 AA for the web experience; support keyboard use, screen readers, readable contrast, and clear non-color status labels.
- **Localization:** Format times, dates, units, and place names according to the passenger’s selected language and operator settings.
- **Security:** Encrypt data in transit and at rest, use role-based access for internal tools, and protect service credentials in managed secret storage.
- **Resilience:** Degrade to schedule and official alert data when real-time services fail, with clear labeling.

## 11. Privacy and retention

- Permit anonymous use for basic arrival and service-information queries.
- Request location access only when needed, explain why, and provide a manual alternative.
- Do not use conversation content to build passenger profiles or for model training by default.
- Minimize collection of identifiers. If notifications require an account or contact method, obtain explicit consent and provide deletion and opt-out controls.
- Define retention periods for conversation logs, analytics, and support handoffs with the operator’s privacy and legal teams before launch.
- Redact or avoid storing sensitive personal information in diagnostic logs.

## 12. Success metrics

### Passenger outcomes

- **Answer success rate:** Share of sampled queries that provide a correct, relevant answer with a supported source.
- **Task completion:** Share of users who find an arrival, alert, or usable trip option without restarting the query.
- **Time to answer:** Median and p95 time from question to useful response.
- **Clarification recovery:** Share of ambiguous queries resolved after one clarification.
- **Passenger satisfaction:** Post-interaction rating and qualitative feedback.

### Operational outcomes

- Reduction in repetitive arrival and service-status contacts, measured against a pre-launch baseline.
- Correct escalation rate for queries the agent cannot safely resolve.
- Feed freshness and availability by source.
- Rate of unsupported claims, wrong stop/route matches, and stale-data mislabeling.
- Accessibility and language coverage for the supported launch scope.

### Initial targets

Targets should be confirmed after baseline measurement and a pilot. Suggested launch gates: at least 95% correctness on a representative arrival-query evaluation set; under 1% unsupported factual claims in audited service answers; at least 90% correct ambiguity handling; and p95 response time under 3 seconds for common lookups.

## 13. Evaluation and launch gates

Before public launch, evaluate representative questions across routes, stops, directions, misspellings, ambiguous names, disrupted service, missing vehicles, stale feeds, and multilingual input if supported. Include adversarial prompts that try to make the agent invent arrival times or ignore official alerts.

Launch requires:

- Sign-off from transit operations on source priority, freshness thresholds, and alert handling.
- Successful validation against a labeled set of passenger queries and expected answers.
- Verified accessibility and privacy review for the selected channel.
- Tested behavior during feed delay, outage, stale data, and conflicting updates.
- A support escalation path and an owner for urgent service-content corrections.
- Monitoring, incident response, and rollback procedures in place.

## 14. Risks and mitigations

| Risk | Mitigation |
|---|---|
| Stale or inaccurate vehicle feed creates misleading ETAs | Show source age, configure freshness limits, degrade to labeled schedule data, and monitor feed health. |
| Similar route or stop names lead to a wrong answer | Ask a clarifying question and show direction and location context before answering. |
| Model fabricates service details | Ground responses in structured sources, constrain answer generation, and audit unsupported claims. |
| Alert data conflicts with vehicle predictions | Define source precedence with operations and show the relevant alert and its scope. |
| Passengers mistake estimates for guarantees | Use estimate language, show uncertainty, and avoid guarantee wording. |
| Accessibility data is incomplete | Only answer from verified attributes and provide an official contact path for unknowns. |
| Demand spikes or upstream outage reduce availability | Cache reference data, apply rate limits, degrade gracefully, and monitor dependencies. |

## 15. Open decisions

- Which city, operator, routes, and passenger channels are in the first release?
- Which real-time feeds and official alert sources are available, and what are their service levels?
- What freshness thresholds and source precedence should operations approve?
- Is trip planning in scope for launch, or only stop-level arrival and alert questions?
- Which languages and accessibility attributes have reliable source data?
- What are the operator’s support hours, escalation method, and privacy retention rules?
- What baseline and target should be used for support-contact reduction and passenger satisfaction?

## 16. Suggested delivery phases

1. **Discovery:** Confirm operator data, channels, user research, accessibility needs, privacy rules, and operational ownership.
2. **Pilot:** Launch arrival lookup and service alerts for a limited geography or route set; review answers and feed health daily.
3. **General availability:** Expand coverage after launch gates pass and support teams are prepared.
4. **Enhancement:** Add trip alternatives, notifications, more languages, and operations analytics based on measured demand.

## 17. Assumptions

- The operator can provide permitted, reasonably reliable schedule, real-time, and alert data.
- The initial experience is informational and does not change transit operations.
- Arrival predictions are estimates and may change as vehicles move or feeds update.
- The transit operator approves the passenger-facing language, data policies, and service escalation details before launch.
