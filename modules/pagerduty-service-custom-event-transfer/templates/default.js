var normalized_event = {
  event_type: PD.Trigger,
  description: "Custom Event Transform",
  details: PD.inputRequest
};

PD.emitGenericEvents([normalized_event]);