import os

import sentry_sdk

sentry_sdk.init(
    dsn=os.environ["SENTRY_DSN"],
    environment="homework",
    send_default_pii=False,
    enable_logs=False,
    traces_sample_rate=0.0,
)

try:
    division_by_zero = 1 / 0
except ZeroDivisionError as error:
    event_id = sentry_sdk.capture_exception(error)
    sentry_sdk.flush(timeout=10)
    print(f"Event ID: {event_id}")
