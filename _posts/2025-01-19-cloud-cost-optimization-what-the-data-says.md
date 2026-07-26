---
layout: post
title:  "What I Learned Writing a Comprehensive Review on Cloud Cost Optimization"
date:   2025-01-19
comments: true
description: A walkthrough of my SSRN paper on cloud cost optimization covering pricing models, optimization techniques, and case studies from Amazon Prime Video and Pinterest.
tags: cloud finops cost-optimization aws gcp azure devops
categories: cloud
---

I spent several months writing a comprehensive review paper on cloud cost optimization. The result, [Cloud Cost Optimization: A Comprehensive Review of Strategies and Case Studies](https://ssrn.com/abstract=4519171), is now available on SSRN/Elsevier and arXiv. This post walks through what the paper covers and the case studies it examines.

## Why This Paper

Cloud cost optimization is a well studied topic, but the literature is scattered across vendor documentation, engineering blogs, and conference talks. There was not a single source that covered pricing models, optimization techniques, and real world case studies together with academic rigor. The paper fills that gap. It is structured in three parts: pricing models, optimization techniques, and case studies.

## Pricing Models

The paper covers eight pricing models across AWS, GCP, and Azure. On demand pricing offers flexibility but is expensive for long running workloads. Reserved instances offer up to 75 percent savings on AWS, 70 percent on GCP, and 80 percent on Azure with a commitment period of one to three years. Spot and preemptible instances offer up to 91 percent off on GCP but carry interruption risk. Savings plans provide a more flexible alternative to reserved instances. Hybrid pricing combines on premises and cloud resources. Consumption based pricing charges per unit of usage with demand sensitive rates. Tiered pricing offers volume discounts based on usage volume. Free tier options serve as an entry point but can mask costs at scale.

![GCP Compute Network Tiered Pricing](/assets/img/blog/tiered-pricing.png)
*Figure 2. GCP Compute Network tiered pricing for egress in Iowa (us-central-1) versus Tokyo (asia-northeast-1). Price per GiB decreases with higher monthly usage.*

The paper includes comparative tables for each model so you can look up the numbers for your specific instance type and region. The optimal choice depends on workload characteristics such as predictability, fault tolerance, duration, and scale.

![AWS Spot Instance Pricing Trends](/assets/img/blog/spot-pricing-trends.png)
*Figure 1. AWS spot instance pricing for c4.large, m4.large, and a1.large instances in us-east-1 over several months. Prices vary based on supply and demand.*

## Optimization Techniques

The core of the paper examines seven areas of cloud cost optimization.

Right sizing compute resources eliminates waste from overprovisioning. A GCP n2 standard 16 instance costs $0.777 per hour compared to $0.388 per hour for an n2 standard 8 instance. If a workload only needs 8 vCPUs, that is $344 per month saved per instance. Spot instances deliver 60 to 73 percent savings over on demand pricing for fault tolerant workloads. ARM Graviton instances cost roughly 40 percent less than equivalent Intel instances on AWS.

![Intel T3 vs ARM A1 Instance Pricing](/assets/img/blog/intel-vs-arm.png)
*Figure 3. Comparing Intel-based T3 instances versus ARM-based A1 Graviton instances on AWS (Linux Reserved Instance Pricing). A1 instances offer significant cost savings across all sizes.*

Data deduplication, compression, and lifecycle management policies reduce storage costs significantly. GCP Archive storage costs $0.0012 per GB per month compared to $0.020 per GB per month for Standard storage. The paper includes region by region pricing tables for all storage tiers across providers.

![GCP Storage Tier Pricing by Region](/assets/img/blog/storage-tiers.png)
*Figure 4. Comparison of Google Cloud Storage tiers (Standard, Nearline, Coldline, Archive) across five regions. Archive storage is the lowest cost option but has retrieval delays.*

Network optimization covers CDNs, edge caching, traffic engineering, and data compression. Twitter adopted Parquet columnar compression for cloud backups, which reduces data transfer costs through column level encoding.

Log filtering, compression, tiered storage, and retention policies manage logging costs. Twitter uses LZO compression for Scribe event logs and Facebook uses the ZStandard library for live logging data. A simple filter that stores only errors and critical events can reduce log storage by 90 percent.

All three major providers offer machine learning powered recommendation engines. AWS provides Cost Explorer, GCP offers Recommenders, and Azure has Advisor. The paper catalogs what each tool offers and where they perform best.

Committed use discounts provide substantial savings for predictable workloads. A GCP n2 standard 16 instance at 1000 vCPU hours per day saves $79,546 per year with a one year commitment and $177,659 over three years.

System re architecture covers microservices versus monolithic design, VM to container migration, serverless adoption, and autoscaling policies. Each approach includes trade off analysis for different workload types.

## Case Studies

### Amazon Prime Video

Prime Video operated an audio video monitoring service built as a distributed microservices architecture using AWS Step Functions for orchestration and Amazon S3 for frame storage. At scale, the per state transition pricing of Step Functions and Tier 1 S3 calls made the architecture prohibitively expensive.

The team re architected the service to a monolith with all components running in a single process. This eliminated the need for Step Functions and S3 entirely. The result was a 90 percent reduction in cost and the ability to handle more traffic. The case study demonstrates that microservices are not automatically the more cost effective choice.

### Pinterest

Pinterest ran Flink data processing clusters on YARN and encountered noisy neighbor problems, CPU banding, and inefficient resource allocation.

The team implemented CGroups soft CPU limits to address CPU isolation issues, which allowed them to downsize their clusters by 20 percent. They migrated from AWS i3 instances to i4i instances, achieving a 40 percent reduction in CPU usage at a 10 percent cost increase. Task placement and colocation optimization reduced costs by 50 to 90 percent on individual jobs. The combined effect was a 35 percent total reduction on the Stream Processing Platform.

## Future Research

The paper identifies six directions for future work. Automated monitoring and optimization using machine learning can continuously identify and fix inefficiencies. Advanced resource allocation techniques can predict workload characteristics and provision resources proactively. Cost performance trade off analysis provides formal methods for balancing savings with service quality. Adaptive scaling and bursting algorithms can account for cost constraints alongside workload patterns. Multi cloud and hybrid cloud optimization addresses environments that span multiple providers. Finally, the intersection of cost optimization and sustainability connects cloud spending with carbon footprint reduction.

## Links

- [SSRN/Elsevier](https://ssrn.com/abstract=4519171)
- [arXiv](https://arxiv.org/abs/2307.12479)

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

*If you are building cloud infrastructure at scale, I would appreciate hearing how these strategies apply to your environment. Reach out on [Twitter](https://twitter.com/saurabhd04) or [LinkedIn](https://www.linkedin.com/in/saurabhdeochake).*
