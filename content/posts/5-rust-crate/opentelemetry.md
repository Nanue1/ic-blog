+++
title = "opentelemetry 提供了一组单独的 API、库、代理和收集器服务，用于从应用程序捕获分布式跟踪和度量"
date = "2021-10-18"

[taxonomies]
tags = ["Crate"]
+++

opentelemetry 提供了一组单独的 API、库、代理和收集器服务，用于从应用程序捕获分布式跟踪和度量

日志

记录构成事务的各个事件。opentelemetry 通常会提供与 fluentd 交互方案。

度量

记录构成一个事务的事件的统计集合。opentelemetry 通常会提供与 prometheus 交互方案。

追踪

测量操作的延迟和识别事务中的性能瓶颈。opentelemetry 通常会提供与 jaeger 交互方案。


当前测试下 prometheus 打点

需要为验证逻辑函数，添加打点功能，通过接口泛化的方式实现。
```rust
pub trait Validate {
    fn validate(&self, val: &str) ->Result<(),String>;
}

```

进行封装打点操作，对于业务函数来说，无感知

```rust 
pub struct WithMetrics<T>(pub T, pub MetricParams);

impl <T: Validate>Validate for WithMetrics<T>{
    fn validate(&self, val: &str) ->Result<(),String> {
        // 处理打点逻辑
        let MetricParams{cx,counter,..} = &self.1;
        let data = &[KeyValue::new("validate_data", val.to_string()),KeyValue::new("service_name", "val.to_string()")];
        counter.add(cx, 1, data);
        // 需要打点得验证逻辑函数
        self.0.validate(val)
    }
}
```

