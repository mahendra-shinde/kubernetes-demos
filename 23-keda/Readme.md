## Event Driven Auto Scaling with KEDA

1.	Install Helm and Add following helm repo

	helm repo add kedacore https://kedacore.github.io/charts
	helm repo update

2.	Install keda in own namespace

	kubectl create ns keda-ns
	helm install keda kedacore/keda -n keda-ns

3.	List all custom resource types (to verify KEDA installation)

	kubectl get crd -l app.kubernetes.io/name=keda-operator

4.	Deploy a sample application.

	kubectl apply -f ./deploy-app.yaml
	kubectl get deploy 
	# You should get replicas size 3

5.	Create rabbitMQ instance on cloud or on kubernetes

6.	Create the [scaled-object for rabitMQ](./keda-rabbit.yaml)

	```yaml
	apiVersion: v1
	kind: Secret
	metadata:
		name: keda-rabbitmq-secret
	data:
		#amqp://guest:guest@my-rabbit.southeastasia.azurecontainer.io:5672/
		host: YW1xcDovL2d1ZXN0Omd1ZXN0QG15LXJhYmJpdC5zb3V0aGVhc3Rhc2lhLmF6dXJlY29udGFpbmVyLmlvOjU2NzIv
	---
	apiVersion: keda.sh/v1alpha1
	kind: TriggerAuthentication
	metadata:
		name: keda-trigger-auth-rabbitmq-conn
	spec:
		secretTargetRef:
		-  parameter: host
		   name: keda-rabbitmq-secret
		   key: host
	---
	apiVersion: keda.sh/v1alpha1
	kind: ScaledObject
	metadata:
		name: rabbitmq-scaledobject
	spec:
		scaleTargetRef:
			name: app1
		minReplicaCount: 1
		pollingInterval: 10
		cooldownPeriod: 10
		triggers:
		-   type: rabbitmq
			metadata:
				protocol: amqp
				queueName: orderQueue
				mode: QueueLength
				value: "20"
				metricName: order-metrics #optional. Generated value would be `rabbitmq-custom-testqueue`
			authenticationRef:
				name: keda-trigger-auth-rabbitmq-conn
	```

7.	Now, apply the keda-scaledObject

	kubectl apply -f keda-rabbit.yaml

8.	Check the autoscaler and scaledObject

	kubectl describe scaledobject rabbitmq-scaledobject
	kubectl get hpa

9.	Visit RabbitMQ Dashboard, and try creating a messageQueue "orderQueue" and send 22 messages.

10.	check the scaledobject

	kubectl describe scaledobject rabbitmq-scaledobject
	kubectl get hpa

