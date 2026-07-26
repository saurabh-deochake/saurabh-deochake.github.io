---
layout: post
title:  "What I Learned Writing a Comprehensive Review on Cloud Cost Optimization"
date:   2025-01-19
comments: true
description: A walkthrough of my SSRN paper on cloud cost optimization — pricing models, optimization techniques, and what Amazon Prime Video and Pinterest's case studies teach us about spending less on cloud infrastructure.
tags: cloud finops cost-optimization aws gcp azure devops
categories: cloud
---

I spent several months writing a comprehensive review paper on cloud cost optimization. The result, **[Cloud Cost Optimization: A Comprehensive Review of Strategies and Case Studies](https://ssrn.com/abstract=4519171)**, is now available on SSRN/Elsevier and arXiv.

This post walks through what the paper covers, the case studies it examines, and why I think this reference is worth your time if you work with cloud infrastructure.

## Why This Paper

Cloud cost optimization is a well-trodden topic, but the literature is scattered across vendor documentation, engineering blogs, and conference talks. There wasn't a single source that covered pricing models, optimization techniques, and real-world case studies together with academic rigor.

The paper fills that gap. It's structured in three parts: pricing models, optimization techniques, and case studies.

## Pricing Models

The paper covers eight pricing models across AWS, GCP, and Azure: on-demand, reserved, spot/preemptible, savings plans, hybrid, consumption-based, tiered, and free-tier. Each section includes provider-specific pricing data and trade-offs.

The takeaway isn't that one model is best — it's that the right choice depends on workload characteristics. Predictable, long-running workloads benefit from reserved instances or savings plans (up to 75% off on-demand with AWS). Fault-tolerant batch workloads can use spot instances (up to 91% off with GCP preemptible VMs). The paper includes comparative tables for each model so you can look up the numbers for your specific instance type and region.

## Optimization Techniques

The core of the paper examines seven areas:

**Compute.** Right-sizing, autoscaling, spot instances, reserved instances, serverless, containerization, and instance type selection (ARM Graviton vs. Intel). Includes concrete pricing comparisons — for example, AWS A1 Graviton instances cost roughly 40% less than equivalent T3 Intel instances.

**Storage.** Data deduplication, compression, lifecycle management, and archival. GCP Archive storage at $0.0012/GB/month versus Standard at $0.020/GB/month is a 16.7x difference. The paper includes region-by-region pricing tables.

**Network.** CDNs, edge caching, traffic engineering, and data compression. Twitter's use of Parquet columnar compression for cloud backups is highlighted as a practical example.

**Logging.** Log filtering, compression (Twitter's LZO, Facebook's ZStandard), tiered storage, and retention policies. A simple filter that stores only errors and critical events can reduce log storage by 90%.

**Resource Recommendations.** AWS Cost Explorer, GCP Recommenders, and Azure Advisor — what each offers and where they excel.

**Committed Use Discounts.** A worked example: a GCP `n2-standard-16` at 1,000 vCPU hours/day saves $79,546/year with a 1-year CUD and $177,659 over three years.

**System Re-architecture.** Microservices vs. monolithic, VM-to-container migration, serverless adoption, and autoscaling policies. Each with trade-off analysis.

## Case Studies

### Amazon Prime Video: 90% Cost Reduction

Prime Video's audio-video monitoring service used AWS Step Functions for orchestration and S3 for frame storage. At scale, the per-state-transition pricing of Step Functions and Tier-1 S3 calls made the architecture prohibitively expensive.

They re-architected to a monolith — all components in a single process, no Step Functions, no S3. The result: 90% cost reduction and the ability to handle more traffic.

The finding that goes against prevailing wisdom: sometimes a monolith is the more cost-effective choice. Microservices aren't automatically better.

### Pinterest: 35% Platform Cost Reduction

Pinterest's Flink data processing clusters ran into noisy neighbor problems, CPU banding, and inefficient resource allocation across YARN clusters.

Their optimization path:
- CGroups soft CPU limits → 20% cluster reduction
- i3 to i4i instance migration → 40% CPU usage reduction at 10% cost increase
- Task placement and colocation optimization → 50-90% cost reduction on individual jobs
- Combined: **35% total reduction** on the Stream Processing Platform

## Future Research

The paper identifies six directions for future work:

1. **Automated monitoring and optimization** — ML-driven frameworks for continuous cost optimization
2. **Advanced resource allocation** — predictive provisioning based on workload characteristics
3. **Cost-performance trade-off analysis** — formal methods for balancing savings with quality
4. **Adaptive scaling and bursting** — cost-aware autoscaling algorithms
5. **Multi-cloud and hybrid cloud optimization** — strategies for environments spanning providers
6. **Sustainability and green computing** — cost optimization intersected with carbon footprint reduction

## The Paper

If you work in cloud infrastructure, FinOps, or platform engineering, this is a reference you can return to when making architectural and pricing decisions.

**[SSRN/Elsevier](https://ssrn.com/abstract=4519171)** | **[arXiv](https://arxiv.org/abs/2307.12479)**

If you find it useful, please cite it:

```bibtex
@article{deochake2023cloudcostoptimization,
  title={Cloud Cost Optimization: A Comprehensive Review of Strategies and Case Studies},
  author={Deochake, Saurabh},
  journal={SSRN Electronic Journal},
  year={2023},
  publisher={Elsevier},
  doi={10.2139/ssrn.4519171},
  url={https://ssrn.com/abstract=4519171}
}
```

---

*If you're building cloud infrastructure at scale, I'd love to hear how these strategies apply to your environment. Reach out on [Twitter](https://twitter.com/saurabhd04) or [LinkedIn](https://www.linkedin.com/in/saurabhdeochake).*
