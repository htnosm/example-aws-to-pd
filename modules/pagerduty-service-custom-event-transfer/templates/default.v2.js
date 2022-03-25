let body = PD.inputRequest.rawBody;

let normalized_event = {
  event_action: PD.Trigger,
  payload: {
    summary: "Custom Event Transform v2",
    source: "raw event",
    severity: PD.Critical,
    custom_details: body
  },
};

PD.emitEventsV2([normalized_event]);
