import os
import sys
import sentry_sdk

sentry_sdk.init(dsn=os.environ["SENTRY_DSN"], environment="homework",
                release="sentry-homework@1.0", send_default_pii=False,
                enable_logs=False, traces_sample_rate=0.0)
cases = {"zero": (lambda: 1 / 0, {"divisor": 0}),
         "value": (lambda: int("netology"), {"value": "netology"}),
         "key": (lambda: {}["missing"], {"key": "missing"})}
selected = sys.argv[1] if len(sys.argv) > 1 else "all"
if selected not in (*cases, "all"):
    raise SystemExit("Usage: sentry_examples.py [zero|value|key|all]")
for name in cases if selected == "all" else [selected]:
    with sentry_sdk.new_scope() as scope:
        scope.set_tag("scenario", name)
        scope.set_context("test_input", cases[name][1])
        try: cases[name][0]()
        except Exception as error: print(name, sentry_sdk.capture_exception(error))
sentry_sdk.flush(timeout=10)
