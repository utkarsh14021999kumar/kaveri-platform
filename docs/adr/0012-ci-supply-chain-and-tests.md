# 0012. CI supply chain pinning, module tests and policy tests
- Status: Accepted - Date: 2026-11-24
**Decision:** Actions pinned to commit SHAs, tool images to digests; updates by PR only. terraform test (mock provider)
and conftest verify run in CI. Every gate has a failure test that asserts the failing step and reason.
**Evidence:** PR #46 (+ failure test #47), PR #49 (+ failure test #50).
