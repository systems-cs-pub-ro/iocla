#ifndef _STRUCTS_H_
#define _STRUCTS_H_

enum sensor_type {
	TIRE,
	PMU
};

typedef struct {
	enum sensor_type sensor_type;
	void *sensor_data;
	int nr_operations;
	int *operations_idxs;
} sensor;

typedef struct __attribute__((__packed__)) {
	float voltage;
	float current;
	float power_consumption;
	int energy_regen;
	int energy_storage;
} power_management_unit;

typedef struct __attribute__((__packed__)) {
	float pressure;
	float temperature;
	int wear_level;
	int performace_score;
} tire_sensor;

#endif // _STRUCTS_H_