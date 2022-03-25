let body = JSON.parse(PD.inputRequest.rawBody);

let summary = body.TopicArn;
let custom_details = body;
if (body.Message) {
    try {
        custom_details.Message = JSON.parse(body.Message);
    } catch(e) {
        ;
    }
}

let normalized_event = {
    event_action: PD.Trigger,
    payload: {
        summary: summary,
        source: "sns",
        severity: PD.Critical,
        custom_details: custom_details
    },
};

PD.emitEventsV2([normalized_event]);
