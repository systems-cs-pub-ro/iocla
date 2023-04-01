#include "structs.h"
#include <stdio.h>

// ------- DO NOT MODIFY ------- //

static void tire_pressure_status(void *data)
{
	tire_sensor *t = (tire_sensor *)data;
	if (t->pressure >= 21 && t->pressure <= 26) {
		printf("Tire has normal pressure.\n");
	} else if (t->pressure > 26 && t->pressure <= 28) {
		printf("Tire has high pressure.\n");
	} else if (t->pressure >= 19 && t->pressure < 21) {
		printf("Tire has low pressure.\n");
	} else {
		printf("Tire has abnormal pressure.\n");
	}
}

static void tire_temperature_status(void *data)
{
	tire_sensor *t = (tire_sensor *)data;
	if (t->temperature >= 0 && t->temperature <= 120) {
		printf("Tire has normal temperature.\n");
	} else {
		printf("Tire has abnormal temperature.\n");
	}
}

static void tire_wear_level_status(void *data)
{
	tire_sensor *t = (tire_sensor *)data;
	if (t->wear_level >= 0 && t->wear_level <= 20) {
		printf("Tire is new.\n");
	} else if (t->wear_level >= 20 && t->wear_level <= 40) {
		printf("Tire is slightly used.\n");
	} else if (t->wear_level >= 40 && t->wear_level <= 60) {
		printf("Tire is used. Consider a pit stop!\n");
	} else {
		printf("Tire is extremely used. Box this lap!\n");
	}
}

static void tire_performance_score(void *data)
{
	tire_sensor *t = (tire_sensor *)data;
	int score = 0;

	// Check pressure
	if (t->pressure >= 21 && t->pressure <= 26) {
		score += 4;
	} else if (t->pressure >= 19 && t->pressure < 21) {
		score += 2;
	} else if (t->pressure > 26 && t->pressure <= 28) {
		score += 3;
	} else {
		score -= 1;
	}

	// Check temperature
	if (t->temperature >= 80 && t->temperature <= 100) {
		score += 4;
	} else if (t->temperature >= 100 && t->temperature < 120) {
		score += 3;
	} else if (t->temperature > 60 && t->temperature <= 80) {
		score += 2;
	} else {
		score -= 1;
	}

	// Check wear level
	if (t->wear_level >= 0 && t->wear_level < 20) {
		score += 4;
	} else if (t->wear_level >= 20 && t->wear_level < 40) {
		score += 2;
	} else if (t->wear_level > 40 && t->wear_level < 60) {
		score -= 1;
	} else {
		score -= 2;
	}

	// Cap the score at 10
	if (score > 10) {
		score = 10;
	} else if (score < 1) {
		score = 1;
	}

	t->performace_score = score;
	printf("The tire performance score is: %d\n", score);
}

static void pmu_compute_power(void *data)
{
	power_management_unit *pmu = (power_management_unit *)data;
	float power = pmu->voltage * pmu->current;

	printf("Power output: %.2f kW.\n", power);
}

static void pmu_regenerate_energy(void *data)
{
	power_management_unit *pmu = (power_management_unit *)data;

	pmu->energy_storage += pmu->energy_regen;
	pmu->energy_regen = 0;

	// Cap the energy storage to 100%
	if (pmu->energy_storage > 100)
		pmu->energy_storage = 100;

	printf("Energy left in storage: %d\n", pmu->energy_storage);
}

static void pmu_get_energy_usage(void *data)
{
	power_management_unit *pmu = (power_management_unit *)data;
	float energy = pmu->power_consumption * pmu->current;

	printf("Energy usage: %.2f kW\n", energy);
}

static void pmu_is_battery_healthy(void *data)
{
	power_management_unit *pmu = (power_management_unit *)data;
	int ok = 0;

	if (pmu->voltage < 10 || pmu->voltage > 20) {
		printf("Battery voltage out of range: %.2fV\n", pmu->voltage);
		ok = 1;
	}

	if (pmu->current < -100 || pmu->current > 100) {
		printf("Battery current out of range: %.2fA\n", pmu->current);
		ok = 1;
	}

	if (pmu->power_consumption < 0 || pmu->power_consumption > 1000) {
		printf("Power consumption out of range: %.2f kW\n",
			   pmu->power_consumption);
		ok = 1;
	}

	if (pmu->energy_regen < 0 || pmu->energy_regen > 100) {
		printf("Energy regeneration out of range: %d%%\n", pmu->energy_regen);
		ok = 1;
	}

	if (pmu->energy_storage < 0 || pmu->energy_storage > 100) {
		printf("Energy storage out of range: %d%%\n", pmu->energy_storage);
		ok = 1;
	}

	if (ok == 1)
		return;

	printf("Battery working as expected!\n");
}

void get_operations(void **operations)
{
	operations[0] = tire_pressure_status;
	operations[1] = tire_temperature_status;
	operations[2] = tire_wear_level_status;
	operations[3] = tire_performance_score;
	operations[4] = pmu_compute_power;
	operations[5] = pmu_regenerate_energy;
	operations[6] = pmu_get_energy_usage;
	operations[7] = pmu_is_battery_healthy;
}

// ------- DO NOT MODIFY ------- //
