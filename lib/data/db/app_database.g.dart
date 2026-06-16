// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
      'sex', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _heightCmMeta =
      const VerificationMeta('heightCm');
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
      'height_cm', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _bodyWeightKgMeta =
      const VerificationMeta('bodyWeightKg');
  @override
  late final GeneratedColumn<double> bodyWeightKg = GeneratedColumn<double>(
      'body_weight_kg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<TrainingExperience, String>
      trainingExperience = GeneratedColumn<String>(
              'training_experience', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TrainingExperience>(
              $UserProfilesTable.$convertertrainingExperience);
  @override
  late final GeneratedColumnWithTypeConverter<TrainingGoal, String>
      primaryGoal = GeneratedColumn<String>('primary_goal', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TrainingGoal>(
              $UserProfilesTable.$converterprimaryGoal);
  static const VerificationMeta _preferredWeightIncrementKgMeta =
      const VerificationMeta('preferredWeightIncrementKg');
  @override
  late final GeneratedColumn<double> preferredWeightIncrementKg =
      GeneratedColumn<double>(
          'preferred_weight_increment_kg', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _restTimerEnabledMeta =
      const VerificationMeta('restTimerEnabled');
  @override
  late final GeneratedColumn<bool> restTimerEnabled = GeneratedColumn<bool>(
      'rest_timer_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("rest_timer_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  late final GeneratedColumnWithTypeConverter<RecommendationStyle?, String>
      recommendationStyle = GeneratedColumn<String>(
              'recommendation_style', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<RecommendationStyle?>(
              $UserProfilesTable.$converterrecommendationStylen);
  static const VerificationMeta _autoEndTimeoutMinutesMeta =
      const VerificationMeta('autoEndTimeoutMinutes');
  @override
  late final GeneratedColumn<int> autoEndTimeoutMinutes = GeneratedColumn<int>(
      'auto_end_timeout_minutes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _restNotificationsEnabledMeta =
      const VerificationMeta('restNotificationsEnabled');
  @override
  late final GeneratedColumn<bool> restNotificationsEnabled =
      GeneratedColumn<bool>(
          'rest_notifications_enabled', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("rest_notifications_enabled" IN (0, 1))'));
  static const VerificationMeta _soundEnabledMeta =
      const VerificationMeta('soundEnabled');
  @override
  late final GeneratedColumn<bool> soundEnabled = GeneratedColumn<bool>(
      'sound_enabled', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sound_enabled" IN (0, 1))'));
  static const VerificationMeta _vibrationEnabledMeta =
      const VerificationMeta('vibrationEnabled');
  @override
  late final GeneratedColumn<bool> vibrationEnabled = GeneratedColumn<bool>(
      'vibration_enabled', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("vibration_enabled" IN (0, 1))'));
  static const VerificationMeta _defaultAddRestSecondsMeta =
      const VerificationMeta('defaultAddRestSeconds');
  @override
  late final GeneratedColumn<int> defaultAddRestSeconds = GeneratedColumn<int>(
      'default_add_rest_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _showRpeRirMeta =
      const VerificationMeta('showRpeRir');
  @override
  late final GeneratedColumn<bool> showRpeRir = GeneratedColumn<bool>(
      'show_rpe_rir', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_rpe_rir" IN (0, 1))'));
  static const VerificationMeta _dumbbellIncrementKgMeta =
      const VerificationMeta('dumbbellIncrementKg');
  @override
  late final GeneratedColumn<double> dumbbellIncrementKg =
      GeneratedColumn<double>('dumbbell_increment_kg', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _barbellIncrementKgMeta =
      const VerificationMeta('barbellIncrementKg');
  @override
  late final GeneratedColumn<double> barbellIncrementKg =
      GeneratedColumn<double>('barbell_increment_kg', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _machineIncrementKgMeta =
      const VerificationMeta('machineIncrementKg');
  @override
  late final GeneratedColumn<double> machineIncrementKg =
      GeneratedColumn<double>('machine_increment_kg', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        age,
        sex,
        heightCm,
        bodyWeightKg,
        trainingExperience,
        primaryGoal,
        preferredWeightIncrementKg,
        restTimerEnabled,
        recommendationStyle,
        autoEndTimeoutMinutes,
        restNotificationsEnabled,
        soundEnabled,
        vibrationEnabled,
        defaultAddRestSeconds,
        showRpeRir,
        dumbbellIncrementKg,
        barbellIncrementKg,
        machineIncrementKg,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<UserProfileRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    }
    if (data.containsKey('sex')) {
      context.handle(
          _sexMeta, sex.isAcceptableOrUnknown(data['sex']!, _sexMeta));
    }
    if (data.containsKey('height_cm')) {
      context.handle(_heightCmMeta,
          heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta));
    }
    if (data.containsKey('body_weight_kg')) {
      context.handle(
          _bodyWeightKgMeta,
          bodyWeightKg.isAcceptableOrUnknown(
              data['body_weight_kg']!, _bodyWeightKgMeta));
    }
    if (data.containsKey('preferred_weight_increment_kg')) {
      context.handle(
          _preferredWeightIncrementKgMeta,
          preferredWeightIncrementKg.isAcceptableOrUnknown(
              data['preferred_weight_increment_kg']!,
              _preferredWeightIncrementKgMeta));
    } else if (isInserting) {
      context.missing(_preferredWeightIncrementKgMeta);
    }
    if (data.containsKey('rest_timer_enabled')) {
      context.handle(
          _restTimerEnabledMeta,
          restTimerEnabled.isAcceptableOrUnknown(
              data['rest_timer_enabled']!, _restTimerEnabledMeta));
    }
    if (data.containsKey('auto_end_timeout_minutes')) {
      context.handle(
          _autoEndTimeoutMinutesMeta,
          autoEndTimeoutMinutes.isAcceptableOrUnknown(
              data['auto_end_timeout_minutes']!, _autoEndTimeoutMinutesMeta));
    }
    if (data.containsKey('rest_notifications_enabled')) {
      context.handle(
          _restNotificationsEnabledMeta,
          restNotificationsEnabled.isAcceptableOrUnknown(
              data['rest_notifications_enabled']!,
              _restNotificationsEnabledMeta));
    }
    if (data.containsKey('sound_enabled')) {
      context.handle(
          _soundEnabledMeta,
          soundEnabled.isAcceptableOrUnknown(
              data['sound_enabled']!, _soundEnabledMeta));
    }
    if (data.containsKey('vibration_enabled')) {
      context.handle(
          _vibrationEnabledMeta,
          vibrationEnabled.isAcceptableOrUnknown(
              data['vibration_enabled']!, _vibrationEnabledMeta));
    }
    if (data.containsKey('default_add_rest_seconds')) {
      context.handle(
          _defaultAddRestSecondsMeta,
          defaultAddRestSeconds.isAcceptableOrUnknown(
              data['default_add_rest_seconds']!, _defaultAddRestSecondsMeta));
    }
    if (data.containsKey('show_rpe_rir')) {
      context.handle(
          _showRpeRirMeta,
          showRpeRir.isAcceptableOrUnknown(
              data['show_rpe_rir']!, _showRpeRirMeta));
    }
    if (data.containsKey('dumbbell_increment_kg')) {
      context.handle(
          _dumbbellIncrementKgMeta,
          dumbbellIncrementKg.isAcceptableOrUnknown(
              data['dumbbell_increment_kg']!, _dumbbellIncrementKgMeta));
    }
    if (data.containsKey('barbell_increment_kg')) {
      context.handle(
          _barbellIncrementKgMeta,
          barbellIncrementKg.isAcceptableOrUnknown(
              data['barbell_increment_kg']!, _barbellIncrementKgMeta));
    }
    if (data.containsKey('machine_increment_kg')) {
      context.handle(
          _machineIncrementKgMeta,
          machineIncrementKg.isAcceptableOrUnknown(
              data['machine_increment_kg']!, _machineIncrementKgMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age']),
      sex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sex']),
      heightCm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height_cm']),
      bodyWeightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}body_weight_kg']),
      trainingExperience: $UserProfilesTable.$convertertrainingExperience
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}training_experience'])!),
      primaryGoal: $UserProfilesTable.$converterprimaryGoal.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}primary_goal'])!),
      preferredWeightIncrementKg: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}preferred_weight_increment_kg'])!,
      restTimerEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}rest_timer_enabled'])!,
      recommendationStyle: $UserProfilesTable.$converterrecommendationStylen
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}recommendation_style'])),
      autoEndTimeoutMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}auto_end_timeout_minutes']),
      restNotificationsEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}rest_notifications_enabled']),
      soundEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sound_enabled']),
      vibrationEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}vibration_enabled']),
      defaultAddRestSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}default_add_rest_seconds']),
      showRpeRir: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}show_rpe_rir']),
      dumbbellIncrementKg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}dumbbell_increment_kg']),
      barbellIncrementKg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}barbell_increment_kg']),
      machineIncrementKg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}machine_increment_kg']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TrainingExperience, String, String>
      $convertertrainingExperience =
      const EnumNameConverter<TrainingExperience>(TrainingExperience.values);
  static JsonTypeConverter2<TrainingGoal, String, String>
      $converterprimaryGoal =
      const EnumNameConverter<TrainingGoal>(TrainingGoal.values);
  static JsonTypeConverter2<RecommendationStyle, String, String>
      $converterrecommendationStyle =
      const EnumNameConverter<RecommendationStyle>(RecommendationStyle.values);
  static JsonTypeConverter2<RecommendationStyle?, String?, String?>
      $converterrecommendationStylen =
      JsonTypeConverter2.asNullable($converterrecommendationStyle);
}

class UserProfileRow extends DataClass implements Insertable<UserProfileRow> {
  final String id;
  final String name;
  final int? age;
  final String? sex;
  final double? heightCm;
  final double? bodyWeightKg;
  final TrainingExperience trainingExperience;
  final TrainingGoal primaryGoal;
  final double preferredWeightIncrementKg;
  final bool restTimerEnabled;
  final RecommendationStyle? recommendationStyle;
  final int? autoEndTimeoutMinutes;
  final bool? restNotificationsEnabled;
  final bool? soundEnabled;
  final bool? vibrationEnabled;
  final int? defaultAddRestSeconds;
  final bool? showRpeRir;
  final double? dumbbellIncrementKg;
  final double? barbellIncrementKg;
  final double? machineIncrementKg;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserProfileRow(
      {required this.id,
      required this.name,
      this.age,
      this.sex,
      this.heightCm,
      this.bodyWeightKg,
      required this.trainingExperience,
      required this.primaryGoal,
      required this.preferredWeightIncrementKg,
      required this.restTimerEnabled,
      this.recommendationStyle,
      this.autoEndTimeoutMinutes,
      this.restNotificationsEnabled,
      this.soundEnabled,
      this.vibrationEnabled,
      this.defaultAddRestSeconds,
      this.showRpeRir,
      this.dumbbellIncrementKg,
      this.barbellIncrementKg,
      this.machineIncrementKg,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    if (!nullToAbsent || sex != null) {
      map['sex'] = Variable<String>(sex);
    }
    if (!nullToAbsent || heightCm != null) {
      map['height_cm'] = Variable<double>(heightCm);
    }
    if (!nullToAbsent || bodyWeightKg != null) {
      map['body_weight_kg'] = Variable<double>(bodyWeightKg);
    }
    {
      map['training_experience'] = Variable<String>($UserProfilesTable
          .$convertertrainingExperience
          .toSql(trainingExperience));
    }
    {
      map['primary_goal'] = Variable<String>(
          $UserProfilesTable.$converterprimaryGoal.toSql(primaryGoal));
    }
    map['preferred_weight_increment_kg'] =
        Variable<double>(preferredWeightIncrementKg);
    map['rest_timer_enabled'] = Variable<bool>(restTimerEnabled);
    if (!nullToAbsent || recommendationStyle != null) {
      map['recommendation_style'] = Variable<String>($UserProfilesTable
          .$converterrecommendationStylen
          .toSql(recommendationStyle));
    }
    if (!nullToAbsent || autoEndTimeoutMinutes != null) {
      map['auto_end_timeout_minutes'] = Variable<int>(autoEndTimeoutMinutes);
    }
    if (!nullToAbsent || restNotificationsEnabled != null) {
      map['rest_notifications_enabled'] =
          Variable<bool>(restNotificationsEnabled);
    }
    if (!nullToAbsent || soundEnabled != null) {
      map['sound_enabled'] = Variable<bool>(soundEnabled);
    }
    if (!nullToAbsent || vibrationEnabled != null) {
      map['vibration_enabled'] = Variable<bool>(vibrationEnabled);
    }
    if (!nullToAbsent || defaultAddRestSeconds != null) {
      map['default_add_rest_seconds'] = Variable<int>(defaultAddRestSeconds);
    }
    if (!nullToAbsent || showRpeRir != null) {
      map['show_rpe_rir'] = Variable<bool>(showRpeRir);
    }
    if (!nullToAbsent || dumbbellIncrementKg != null) {
      map['dumbbell_increment_kg'] = Variable<double>(dumbbellIncrementKg);
    }
    if (!nullToAbsent || barbellIncrementKg != null) {
      map['barbell_increment_kg'] = Variable<double>(barbellIncrementKg);
    }
    if (!nullToAbsent || machineIncrementKg != null) {
      map['machine_increment_kg'] = Variable<double>(machineIncrementKg);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      name: Value(name),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      sex: sex == null && nullToAbsent ? const Value.absent() : Value(sex),
      heightCm: heightCm == null && nullToAbsent
          ? const Value.absent()
          : Value(heightCm),
      bodyWeightKg: bodyWeightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyWeightKg),
      trainingExperience: Value(trainingExperience),
      primaryGoal: Value(primaryGoal),
      preferredWeightIncrementKg: Value(preferredWeightIncrementKg),
      restTimerEnabled: Value(restTimerEnabled),
      recommendationStyle: recommendationStyle == null && nullToAbsent
          ? const Value.absent()
          : Value(recommendationStyle),
      autoEndTimeoutMinutes: autoEndTimeoutMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(autoEndTimeoutMinutes),
      restNotificationsEnabled: restNotificationsEnabled == null && nullToAbsent
          ? const Value.absent()
          : Value(restNotificationsEnabled),
      soundEnabled: soundEnabled == null && nullToAbsent
          ? const Value.absent()
          : Value(soundEnabled),
      vibrationEnabled: vibrationEnabled == null && nullToAbsent
          ? const Value.absent()
          : Value(vibrationEnabled),
      defaultAddRestSeconds: defaultAddRestSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultAddRestSeconds),
      showRpeRir: showRpeRir == null && nullToAbsent
          ? const Value.absent()
          : Value(showRpeRir),
      dumbbellIncrementKg: dumbbellIncrementKg == null && nullToAbsent
          ? const Value.absent()
          : Value(dumbbellIncrementKg),
      barbellIncrementKg: barbellIncrementKg == null && nullToAbsent
          ? const Value.absent()
          : Value(barbellIncrementKg),
      machineIncrementKg: machineIncrementKg == null && nullToAbsent
          ? const Value.absent()
          : Value(machineIncrementKg),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserProfileRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      age: serializer.fromJson<int?>(json['age']),
      sex: serializer.fromJson<String?>(json['sex']),
      heightCm: serializer.fromJson<double?>(json['heightCm']),
      bodyWeightKg: serializer.fromJson<double?>(json['bodyWeightKg']),
      trainingExperience: $UserProfilesTable.$convertertrainingExperience
          .fromJson(serializer.fromJson<String>(json['trainingExperience'])),
      primaryGoal: $UserProfilesTable.$converterprimaryGoal
          .fromJson(serializer.fromJson<String>(json['primaryGoal'])),
      preferredWeightIncrementKg:
          serializer.fromJson<double>(json['preferredWeightIncrementKg']),
      restTimerEnabled: serializer.fromJson<bool>(json['restTimerEnabled']),
      recommendationStyle: $UserProfilesTable.$converterrecommendationStylen
          .fromJson(serializer.fromJson<String?>(json['recommendationStyle'])),
      autoEndTimeoutMinutes:
          serializer.fromJson<int?>(json['autoEndTimeoutMinutes']),
      restNotificationsEnabled:
          serializer.fromJson<bool?>(json['restNotificationsEnabled']),
      soundEnabled: serializer.fromJson<bool?>(json['soundEnabled']),
      vibrationEnabled: serializer.fromJson<bool?>(json['vibrationEnabled']),
      defaultAddRestSeconds:
          serializer.fromJson<int?>(json['defaultAddRestSeconds']),
      showRpeRir: serializer.fromJson<bool?>(json['showRpeRir']),
      dumbbellIncrementKg:
          serializer.fromJson<double?>(json['dumbbellIncrementKg']),
      barbellIncrementKg:
          serializer.fromJson<double?>(json['barbellIncrementKg']),
      machineIncrementKg:
          serializer.fromJson<double?>(json['machineIncrementKg']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'age': serializer.toJson<int?>(age),
      'sex': serializer.toJson<String?>(sex),
      'heightCm': serializer.toJson<double?>(heightCm),
      'bodyWeightKg': serializer.toJson<double?>(bodyWeightKg),
      'trainingExperience': serializer.toJson<String>($UserProfilesTable
          .$convertertrainingExperience
          .toJson(trainingExperience)),
      'primaryGoal': serializer.toJson<String>(
          $UserProfilesTable.$converterprimaryGoal.toJson(primaryGoal)),
      'preferredWeightIncrementKg':
          serializer.toJson<double>(preferredWeightIncrementKg),
      'restTimerEnabled': serializer.toJson<bool>(restTimerEnabled),
      'recommendationStyle': serializer.toJson<String?>($UserProfilesTable
          .$converterrecommendationStylen
          .toJson(recommendationStyle)),
      'autoEndTimeoutMinutes': serializer.toJson<int?>(autoEndTimeoutMinutes),
      'restNotificationsEnabled':
          serializer.toJson<bool?>(restNotificationsEnabled),
      'soundEnabled': serializer.toJson<bool?>(soundEnabled),
      'vibrationEnabled': serializer.toJson<bool?>(vibrationEnabled),
      'defaultAddRestSeconds': serializer.toJson<int?>(defaultAddRestSeconds),
      'showRpeRir': serializer.toJson<bool?>(showRpeRir),
      'dumbbellIncrementKg': serializer.toJson<double?>(dumbbellIncrementKg),
      'barbellIncrementKg': serializer.toJson<double?>(barbellIncrementKg),
      'machineIncrementKg': serializer.toJson<double?>(machineIncrementKg),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserProfileRow copyWith(
          {String? id,
          String? name,
          Value<int?> age = const Value.absent(),
          Value<String?> sex = const Value.absent(),
          Value<double?> heightCm = const Value.absent(),
          Value<double?> bodyWeightKg = const Value.absent(),
          TrainingExperience? trainingExperience,
          TrainingGoal? primaryGoal,
          double? preferredWeightIncrementKg,
          bool? restTimerEnabled,
          Value<RecommendationStyle?> recommendationStyle =
              const Value.absent(),
          Value<int?> autoEndTimeoutMinutes = const Value.absent(),
          Value<bool?> restNotificationsEnabled = const Value.absent(),
          Value<bool?> soundEnabled = const Value.absent(),
          Value<bool?> vibrationEnabled = const Value.absent(),
          Value<int?> defaultAddRestSeconds = const Value.absent(),
          Value<bool?> showRpeRir = const Value.absent(),
          Value<double?> dumbbellIncrementKg = const Value.absent(),
          Value<double?> barbellIncrementKg = const Value.absent(),
          Value<double?> machineIncrementKg = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      UserProfileRow(
        id: id ?? this.id,
        name: name ?? this.name,
        age: age.present ? age.value : this.age,
        sex: sex.present ? sex.value : this.sex,
        heightCm: heightCm.present ? heightCm.value : this.heightCm,
        bodyWeightKg:
            bodyWeightKg.present ? bodyWeightKg.value : this.bodyWeightKg,
        trainingExperience: trainingExperience ?? this.trainingExperience,
        primaryGoal: primaryGoal ?? this.primaryGoal,
        preferredWeightIncrementKg:
            preferredWeightIncrementKg ?? this.preferredWeightIncrementKg,
        restTimerEnabled: restTimerEnabled ?? this.restTimerEnabled,
        recommendationStyle: recommendationStyle.present
            ? recommendationStyle.value
            : this.recommendationStyle,
        autoEndTimeoutMinutes: autoEndTimeoutMinutes.present
            ? autoEndTimeoutMinutes.value
            : this.autoEndTimeoutMinutes,
        restNotificationsEnabled: restNotificationsEnabled.present
            ? restNotificationsEnabled.value
            : this.restNotificationsEnabled,
        soundEnabled:
            soundEnabled.present ? soundEnabled.value : this.soundEnabled,
        vibrationEnabled: vibrationEnabled.present
            ? vibrationEnabled.value
            : this.vibrationEnabled,
        defaultAddRestSeconds: defaultAddRestSeconds.present
            ? defaultAddRestSeconds.value
            : this.defaultAddRestSeconds,
        showRpeRir: showRpeRir.present ? showRpeRir.value : this.showRpeRir,
        dumbbellIncrementKg: dumbbellIncrementKg.present
            ? dumbbellIncrementKg.value
            : this.dumbbellIncrementKg,
        barbellIncrementKg: barbellIncrementKg.present
            ? barbellIncrementKg.value
            : this.barbellIncrementKg,
        machineIncrementKg: machineIncrementKg.present
            ? machineIncrementKg.value
            : this.machineIncrementKg,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UserProfileRow copyWithCompanion(UserProfilesCompanion data) {
    return UserProfileRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      age: data.age.present ? data.age.value : this.age,
      sex: data.sex.present ? data.sex.value : this.sex,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      bodyWeightKg: data.bodyWeightKg.present
          ? data.bodyWeightKg.value
          : this.bodyWeightKg,
      trainingExperience: data.trainingExperience.present
          ? data.trainingExperience.value
          : this.trainingExperience,
      primaryGoal:
          data.primaryGoal.present ? data.primaryGoal.value : this.primaryGoal,
      preferredWeightIncrementKg: data.preferredWeightIncrementKg.present
          ? data.preferredWeightIncrementKg.value
          : this.preferredWeightIncrementKg,
      restTimerEnabled: data.restTimerEnabled.present
          ? data.restTimerEnabled.value
          : this.restTimerEnabled,
      recommendationStyle: data.recommendationStyle.present
          ? data.recommendationStyle.value
          : this.recommendationStyle,
      autoEndTimeoutMinutes: data.autoEndTimeoutMinutes.present
          ? data.autoEndTimeoutMinutes.value
          : this.autoEndTimeoutMinutes,
      restNotificationsEnabled: data.restNotificationsEnabled.present
          ? data.restNotificationsEnabled.value
          : this.restNotificationsEnabled,
      soundEnabled: data.soundEnabled.present
          ? data.soundEnabled.value
          : this.soundEnabled,
      vibrationEnabled: data.vibrationEnabled.present
          ? data.vibrationEnabled.value
          : this.vibrationEnabled,
      defaultAddRestSeconds: data.defaultAddRestSeconds.present
          ? data.defaultAddRestSeconds.value
          : this.defaultAddRestSeconds,
      showRpeRir:
          data.showRpeRir.present ? data.showRpeRir.value : this.showRpeRir,
      dumbbellIncrementKg: data.dumbbellIncrementKg.present
          ? data.dumbbellIncrementKg.value
          : this.dumbbellIncrementKg,
      barbellIncrementKg: data.barbellIncrementKg.present
          ? data.barbellIncrementKg.value
          : this.barbellIncrementKg,
      machineIncrementKg: data.machineIncrementKg.present
          ? data.machineIncrementKg.value
          : this.machineIncrementKg,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('age: $age, ')
          ..write('sex: $sex, ')
          ..write('heightCm: $heightCm, ')
          ..write('bodyWeightKg: $bodyWeightKg, ')
          ..write('trainingExperience: $trainingExperience, ')
          ..write('primaryGoal: $primaryGoal, ')
          ..write('preferredWeightIncrementKg: $preferredWeightIncrementKg, ')
          ..write('restTimerEnabled: $restTimerEnabled, ')
          ..write('recommendationStyle: $recommendationStyle, ')
          ..write('autoEndTimeoutMinutes: $autoEndTimeoutMinutes, ')
          ..write('restNotificationsEnabled: $restNotificationsEnabled, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('vibrationEnabled: $vibrationEnabled, ')
          ..write('defaultAddRestSeconds: $defaultAddRestSeconds, ')
          ..write('showRpeRir: $showRpeRir, ')
          ..write('dumbbellIncrementKg: $dumbbellIncrementKg, ')
          ..write('barbellIncrementKg: $barbellIncrementKg, ')
          ..write('machineIncrementKg: $machineIncrementKg, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        name,
        age,
        sex,
        heightCm,
        bodyWeightKg,
        trainingExperience,
        primaryGoal,
        preferredWeightIncrementKg,
        restTimerEnabled,
        recommendationStyle,
        autoEndTimeoutMinutes,
        restNotificationsEnabled,
        soundEnabled,
        vibrationEnabled,
        defaultAddRestSeconds,
        showRpeRir,
        dumbbellIncrementKg,
        barbellIncrementKg,
        machineIncrementKg,
        createdAt,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.age == this.age &&
          other.sex == this.sex &&
          other.heightCm == this.heightCm &&
          other.bodyWeightKg == this.bodyWeightKg &&
          other.trainingExperience == this.trainingExperience &&
          other.primaryGoal == this.primaryGoal &&
          other.preferredWeightIncrementKg == this.preferredWeightIncrementKg &&
          other.restTimerEnabled == this.restTimerEnabled &&
          other.recommendationStyle == this.recommendationStyle &&
          other.autoEndTimeoutMinutes == this.autoEndTimeoutMinutes &&
          other.restNotificationsEnabled == this.restNotificationsEnabled &&
          other.soundEnabled == this.soundEnabled &&
          other.vibrationEnabled == this.vibrationEnabled &&
          other.defaultAddRestSeconds == this.defaultAddRestSeconds &&
          other.showRpeRir == this.showRpeRir &&
          other.dumbbellIncrementKg == this.dumbbellIncrementKg &&
          other.barbellIncrementKg == this.barbellIncrementKg &&
          other.machineIncrementKg == this.machineIncrementKg &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfileRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<int?> age;
  final Value<String?> sex;
  final Value<double?> heightCm;
  final Value<double?> bodyWeightKg;
  final Value<TrainingExperience> trainingExperience;
  final Value<TrainingGoal> primaryGoal;
  final Value<double> preferredWeightIncrementKg;
  final Value<bool> restTimerEnabled;
  final Value<RecommendationStyle?> recommendationStyle;
  final Value<int?> autoEndTimeoutMinutes;
  final Value<bool?> restNotificationsEnabled;
  final Value<bool?> soundEnabled;
  final Value<bool?> vibrationEnabled;
  final Value<int?> defaultAddRestSeconds;
  final Value<bool?> showRpeRir;
  final Value<double?> dumbbellIncrementKg;
  final Value<double?> barbellIncrementKg;
  final Value<double?> machineIncrementKg;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.age = const Value.absent(),
    this.sex = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.bodyWeightKg = const Value.absent(),
    this.trainingExperience = const Value.absent(),
    this.primaryGoal = const Value.absent(),
    this.preferredWeightIncrementKg = const Value.absent(),
    this.restTimerEnabled = const Value.absent(),
    this.recommendationStyle = const Value.absent(),
    this.autoEndTimeoutMinutes = const Value.absent(),
    this.restNotificationsEnabled = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.vibrationEnabled = const Value.absent(),
    this.defaultAddRestSeconds = const Value.absent(),
    this.showRpeRir = const Value.absent(),
    this.dumbbellIncrementKg = const Value.absent(),
    this.barbellIncrementKg = const Value.absent(),
    this.machineIncrementKg = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    required String id,
    required String name,
    this.age = const Value.absent(),
    this.sex = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.bodyWeightKg = const Value.absent(),
    required TrainingExperience trainingExperience,
    required TrainingGoal primaryGoal,
    required double preferredWeightIncrementKg,
    this.restTimerEnabled = const Value.absent(),
    this.recommendationStyle = const Value.absent(),
    this.autoEndTimeoutMinutes = const Value.absent(),
    this.restNotificationsEnabled = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.vibrationEnabled = const Value.absent(),
    this.defaultAddRestSeconds = const Value.absent(),
    this.showRpeRir = const Value.absent(),
    this.dumbbellIncrementKg = const Value.absent(),
    this.barbellIncrementKg = const Value.absent(),
    this.machineIncrementKg = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        trainingExperience = Value(trainingExperience),
        primaryGoal = Value(primaryGoal),
        preferredWeightIncrementKg = Value(preferredWeightIncrementKg),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<UserProfileRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? age,
    Expression<String>? sex,
    Expression<double>? heightCm,
    Expression<double>? bodyWeightKg,
    Expression<String>? trainingExperience,
    Expression<String>? primaryGoal,
    Expression<double>? preferredWeightIncrementKg,
    Expression<bool>? restTimerEnabled,
    Expression<String>? recommendationStyle,
    Expression<int>? autoEndTimeoutMinutes,
    Expression<bool>? restNotificationsEnabled,
    Expression<bool>? soundEnabled,
    Expression<bool>? vibrationEnabled,
    Expression<int>? defaultAddRestSeconds,
    Expression<bool>? showRpeRir,
    Expression<double>? dumbbellIncrementKg,
    Expression<double>? barbellIncrementKg,
    Expression<double>? machineIncrementKg,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (age != null) 'age': age,
      if (sex != null) 'sex': sex,
      if (heightCm != null) 'height_cm': heightCm,
      if (bodyWeightKg != null) 'body_weight_kg': bodyWeightKg,
      if (trainingExperience != null) 'training_experience': trainingExperience,
      if (primaryGoal != null) 'primary_goal': primaryGoal,
      if (preferredWeightIncrementKg != null)
        'preferred_weight_increment_kg': preferredWeightIncrementKg,
      if (restTimerEnabled != null) 'rest_timer_enabled': restTimerEnabled,
      if (recommendationStyle != null)
        'recommendation_style': recommendationStyle,
      if (autoEndTimeoutMinutes != null)
        'auto_end_timeout_minutes': autoEndTimeoutMinutes,
      if (restNotificationsEnabled != null)
        'rest_notifications_enabled': restNotificationsEnabled,
      if (soundEnabled != null) 'sound_enabled': soundEnabled,
      if (vibrationEnabled != null) 'vibration_enabled': vibrationEnabled,
      if (defaultAddRestSeconds != null)
        'default_add_rest_seconds': defaultAddRestSeconds,
      if (showRpeRir != null) 'show_rpe_rir': showRpeRir,
      if (dumbbellIncrementKg != null)
        'dumbbell_increment_kg': dumbbellIncrementKg,
      if (barbellIncrementKg != null)
        'barbell_increment_kg': barbellIncrementKg,
      if (machineIncrementKg != null)
        'machine_increment_kg': machineIncrementKg,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<int?>? age,
      Value<String?>? sex,
      Value<double?>? heightCm,
      Value<double?>? bodyWeightKg,
      Value<TrainingExperience>? trainingExperience,
      Value<TrainingGoal>? primaryGoal,
      Value<double>? preferredWeightIncrementKg,
      Value<bool>? restTimerEnabled,
      Value<RecommendationStyle?>? recommendationStyle,
      Value<int?>? autoEndTimeoutMinutes,
      Value<bool?>? restNotificationsEnabled,
      Value<bool?>? soundEnabled,
      Value<bool?>? vibrationEnabled,
      Value<int?>? defaultAddRestSeconds,
      Value<bool?>? showRpeRir,
      Value<double?>? dumbbellIncrementKg,
      Value<double?>? barbellIncrementKg,
      Value<double?>? machineIncrementKg,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      sex: sex ?? this.sex,
      heightCm: heightCm ?? this.heightCm,
      bodyWeightKg: bodyWeightKg ?? this.bodyWeightKg,
      trainingExperience: trainingExperience ?? this.trainingExperience,
      primaryGoal: primaryGoal ?? this.primaryGoal,
      preferredWeightIncrementKg:
          preferredWeightIncrementKg ?? this.preferredWeightIncrementKg,
      restTimerEnabled: restTimerEnabled ?? this.restTimerEnabled,
      recommendationStyle: recommendationStyle ?? this.recommendationStyle,
      autoEndTimeoutMinutes:
          autoEndTimeoutMinutes ?? this.autoEndTimeoutMinutes,
      restNotificationsEnabled:
          restNotificationsEnabled ?? this.restNotificationsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      defaultAddRestSeconds:
          defaultAddRestSeconds ?? this.defaultAddRestSeconds,
      showRpeRir: showRpeRir ?? this.showRpeRir,
      dumbbellIncrementKg: dumbbellIncrementKg ?? this.dumbbellIncrementKg,
      barbellIncrementKg: barbellIncrementKg ?? this.barbellIncrementKg,
      machineIncrementKg: machineIncrementKg ?? this.machineIncrementKg,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (bodyWeightKg.present) {
      map['body_weight_kg'] = Variable<double>(bodyWeightKg.value);
    }
    if (trainingExperience.present) {
      map['training_experience'] = Variable<String>($UserProfilesTable
          .$convertertrainingExperience
          .toSql(trainingExperience.value));
    }
    if (primaryGoal.present) {
      map['primary_goal'] = Variable<String>(
          $UserProfilesTable.$converterprimaryGoal.toSql(primaryGoal.value));
    }
    if (preferredWeightIncrementKg.present) {
      map['preferred_weight_increment_kg'] =
          Variable<double>(preferredWeightIncrementKg.value);
    }
    if (restTimerEnabled.present) {
      map['rest_timer_enabled'] = Variable<bool>(restTimerEnabled.value);
    }
    if (recommendationStyle.present) {
      map['recommendation_style'] = Variable<String>($UserProfilesTable
          .$converterrecommendationStylen
          .toSql(recommendationStyle.value));
    }
    if (autoEndTimeoutMinutes.present) {
      map['auto_end_timeout_minutes'] =
          Variable<int>(autoEndTimeoutMinutes.value);
    }
    if (restNotificationsEnabled.present) {
      map['rest_notifications_enabled'] =
          Variable<bool>(restNotificationsEnabled.value);
    }
    if (soundEnabled.present) {
      map['sound_enabled'] = Variable<bool>(soundEnabled.value);
    }
    if (vibrationEnabled.present) {
      map['vibration_enabled'] = Variable<bool>(vibrationEnabled.value);
    }
    if (defaultAddRestSeconds.present) {
      map['default_add_rest_seconds'] =
          Variable<int>(defaultAddRestSeconds.value);
    }
    if (showRpeRir.present) {
      map['show_rpe_rir'] = Variable<bool>(showRpeRir.value);
    }
    if (dumbbellIncrementKg.present) {
      map['dumbbell_increment_kg'] =
          Variable<double>(dumbbellIncrementKg.value);
    }
    if (barbellIncrementKg.present) {
      map['barbell_increment_kg'] = Variable<double>(barbellIncrementKg.value);
    }
    if (machineIncrementKg.present) {
      map['machine_increment_kg'] = Variable<double>(machineIncrementKg.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('age: $age, ')
          ..write('sex: $sex, ')
          ..write('heightCm: $heightCm, ')
          ..write('bodyWeightKg: $bodyWeightKg, ')
          ..write('trainingExperience: $trainingExperience, ')
          ..write('primaryGoal: $primaryGoal, ')
          ..write('preferredWeightIncrementKg: $preferredWeightIncrementKg, ')
          ..write('restTimerEnabled: $restTimerEnabled, ')
          ..write('recommendationStyle: $recommendationStyle, ')
          ..write('autoEndTimeoutMinutes: $autoEndTimeoutMinutes, ')
          ..write('restNotificationsEnabled: $restNotificationsEnabled, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('vibrationEnabled: $vibrationEnabled, ')
          ..write('defaultAddRestSeconds: $defaultAddRestSeconds, ')
          ..write('showRpeRir: $showRpeRir, ')
          ..write('dumbbellIncrementKg: $dumbbellIncrementKg, ')
          ..write('barbellIncrementKg: $barbellIncrementKg, ')
          ..write('machineIncrementKg: $machineIncrementKg, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, ExerciseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<DayType?, String> dayType =
      GeneratedColumn<String>('day_type', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<DayType?>($ExercisesTable.$converterdayTypen);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _primaryMuscleGroupMeta =
      const VerificationMeta('primaryMuscleGroup');
  @override
  late final GeneratedColumn<String> primaryMuscleGroup =
      GeneratedColumn<String>('primary_muscle_group', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _secondaryMuscleGroupsMeta =
      const VerificationMeta('secondaryMuscleGroups');
  @override
  late final GeneratedColumn<String> secondaryMuscleGroups =
      GeneratedColumn<String>('secondary_muscle_groups', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant(''));
  static const VerificationMeta _movementPatternMeta =
      const VerificationMeta('movementPattern');
  @override
  late final GeneratedColumn<String> movementPattern = GeneratedColumn<String>(
      'movement_pattern', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  late final GeneratedColumnWithTypeConverter<EquipmentType, String>
      equipmentType = GeneratedColumn<String>(
              'equipment_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<EquipmentType>(
              $ExercisesTable.$converterequipmentType);
  @override
  late final GeneratedColumnWithTypeConverter<ExerciseCategory?, String>
      exerciseCategory = GeneratedColumn<String>(
              'exercise_category', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ExerciseCategory?>(
              $ExercisesTable.$converterexerciseCategoryn);
  static const VerificationMeta _isBodyweightMeta =
      const VerificationMeta('isBodyweight');
  @override
  late final GeneratedColumn<bool> isBodyweight = GeneratedColumn<bool>(
      'is_bodyweight', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_bodyweight" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isUnilateralMeta =
      const VerificationMeta('isUnilateral');
  @override
  late final GeneratedColumn<bool> isUnilateral = GeneratedColumn<bool>(
      'is_unilateral', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_unilateral" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _defaultIncrementKgMeta =
      const VerificationMeta('defaultIncrementKg');
  @override
  late final GeneratedColumn<double> defaultIncrementKg =
      GeneratedColumn<double>('default_increment_kg', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _minimumRecommendedRepsMeta =
      const VerificationMeta('minimumRecommendedReps');
  @override
  late final GeneratedColumn<int> minimumRecommendedReps = GeneratedColumn<int>(
      'minimum_recommended_reps', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _maximumRecommendedRepsMeta =
      const VerificationMeta('maximumRecommendedReps');
  @override
  late final GeneratedColumn<int> maximumRecommendedReps = GeneratedColumn<int>(
      'maximum_recommended_reps', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _defaultRestSecondsMeta =
      const VerificationMeta('defaultRestSeconds');
  @override
  late final GeneratedColumn<int> defaultRestSeconds = GeneratedColumn<int>(
      'default_rest_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _recommendedSetRangeMinMeta =
      const VerificationMeta('recommendedSetRangeMin');
  @override
  late final GeneratedColumn<int> recommendedSetRangeMin = GeneratedColumn<int>(
      'recommended_set_range_min', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _recommendedSetRangeMaxMeta =
      const VerificationMeta('recommendedSetRangeMax');
  @override
  late final GeneratedColumn<int> recommendedSetRangeMax = GeneratedColumn<int>(
      'recommended_set_range_max', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isCustomMeta =
      const VerificationMeta('isCustom');
  @override
  late final GeneratedColumn<bool> isCustom = GeneratedColumn<bool>(
      'is_custom', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_custom" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        dayType,
        tags,
        primaryMuscleGroup,
        secondaryMuscleGroups,
        movementPattern,
        equipmentType,
        exerciseCategory,
        isBodyweight,
        isUnilateral,
        defaultIncrementKg,
        minimumRecommendedReps,
        maximumRecommendedReps,
        defaultRestSeconds,
        recommendedSetRangeMin,
        recommendedSetRangeMax,
        notes,
        isCustom,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(Insertable<ExerciseRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('primary_muscle_group')) {
      context.handle(
          _primaryMuscleGroupMeta,
          primaryMuscleGroup.isAcceptableOrUnknown(
              data['primary_muscle_group']!, _primaryMuscleGroupMeta));
    } else if (isInserting) {
      context.missing(_primaryMuscleGroupMeta);
    }
    if (data.containsKey('secondary_muscle_groups')) {
      context.handle(
          _secondaryMuscleGroupsMeta,
          secondaryMuscleGroups.isAcceptableOrUnknown(
              data['secondary_muscle_groups']!, _secondaryMuscleGroupsMeta));
    }
    if (data.containsKey('movement_pattern')) {
      context.handle(
          _movementPatternMeta,
          movementPattern.isAcceptableOrUnknown(
              data['movement_pattern']!, _movementPatternMeta));
    }
    if (data.containsKey('is_bodyweight')) {
      context.handle(
          _isBodyweightMeta,
          isBodyweight.isAcceptableOrUnknown(
              data['is_bodyweight']!, _isBodyweightMeta));
    }
    if (data.containsKey('is_unilateral')) {
      context.handle(
          _isUnilateralMeta,
          isUnilateral.isAcceptableOrUnknown(
              data['is_unilateral']!, _isUnilateralMeta));
    }
    if (data.containsKey('default_increment_kg')) {
      context.handle(
          _defaultIncrementKgMeta,
          defaultIncrementKg.isAcceptableOrUnknown(
              data['default_increment_kg']!, _defaultIncrementKgMeta));
    }
    if (data.containsKey('minimum_recommended_reps')) {
      context.handle(
          _minimumRecommendedRepsMeta,
          minimumRecommendedReps.isAcceptableOrUnknown(
              data['minimum_recommended_reps']!, _minimumRecommendedRepsMeta));
    }
    if (data.containsKey('maximum_recommended_reps')) {
      context.handle(
          _maximumRecommendedRepsMeta,
          maximumRecommendedReps.isAcceptableOrUnknown(
              data['maximum_recommended_reps']!, _maximumRecommendedRepsMeta));
    }
    if (data.containsKey('default_rest_seconds')) {
      context.handle(
          _defaultRestSecondsMeta,
          defaultRestSeconds.isAcceptableOrUnknown(
              data['default_rest_seconds']!, _defaultRestSecondsMeta));
    }
    if (data.containsKey('recommended_set_range_min')) {
      context.handle(
          _recommendedSetRangeMinMeta,
          recommendedSetRangeMin.isAcceptableOrUnknown(
              data['recommended_set_range_min']!, _recommendedSetRangeMinMeta));
    }
    if (data.containsKey('recommended_set_range_max')) {
      context.handle(
          _recommendedSetRangeMaxMeta,
          recommendedSetRangeMax.isAcceptableOrUnknown(
              data['recommended_set_range_max']!, _recommendedSetRangeMaxMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('is_custom')) {
      context.handle(_isCustomMeta,
          isCustom.isAcceptableOrUnknown(data['is_custom']!, _isCustomMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      dayType: $ExercisesTable.$converterdayTypen.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}day_type'])),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
      primaryMuscleGroup: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}primary_muscle_group'])!,
      secondaryMuscleGroups: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}secondary_muscle_groups'])!,
      movementPattern: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}movement_pattern'])!,
      equipmentType: $ExercisesTable.$converterequipmentType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}equipment_type'])!),
      exerciseCategory: $ExercisesTable.$converterexerciseCategoryn.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}exercise_category'])),
      isBodyweight: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_bodyweight'])!,
      isUnilateral: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_unilateral'])!,
      defaultIncrementKg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}default_increment_kg']),
      minimumRecommendedReps: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}minimum_recommended_reps']),
      maximumRecommendedReps: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}maximum_recommended_reps']),
      defaultRestSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}default_rest_seconds']),
      recommendedSetRangeMin: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}recommended_set_range_min']),
      recommendedSetRangeMax: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}recommended_set_range_max']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      isCustom: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_custom'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DayType, String, String> $converterdayType =
      const EnumNameConverter<DayType>(DayType.values);
  static JsonTypeConverter2<DayType?, String?, String?> $converterdayTypen =
      JsonTypeConverter2.asNullable($converterdayType);
  static JsonTypeConverter2<EquipmentType, String, String>
      $converterequipmentType =
      const EnumNameConverter<EquipmentType>(EquipmentType.values);
  static JsonTypeConverter2<ExerciseCategory, String, String>
      $converterexerciseCategory =
      const EnumNameConverter<ExerciseCategory>(ExerciseCategory.values);
  static JsonTypeConverter2<ExerciseCategory?, String?, String?>
      $converterexerciseCategoryn =
      JsonTypeConverter2.asNullable($converterexerciseCategory);
}

class ExerciseRow extends DataClass implements Insertable<ExerciseRow> {
  final String id;
  final String name;
  final DayType? dayType;
  final String tags;
  final String primaryMuscleGroup;
  final String secondaryMuscleGroups;
  final String movementPattern;
  final EquipmentType equipmentType;
  final ExerciseCategory? exerciseCategory;
  final bool isBodyweight;
  final bool isUnilateral;
  final double? defaultIncrementKg;
  final int? minimumRecommendedReps;
  final int? maximumRecommendedReps;
  final int? defaultRestSeconds;
  final int? recommendedSetRangeMin;
  final int? recommendedSetRangeMax;
  final String? notes;
  final bool isCustom;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ExerciseRow(
      {required this.id,
      required this.name,
      this.dayType,
      required this.tags,
      required this.primaryMuscleGroup,
      required this.secondaryMuscleGroups,
      required this.movementPattern,
      required this.equipmentType,
      this.exerciseCategory,
      required this.isBodyweight,
      required this.isUnilateral,
      this.defaultIncrementKg,
      this.minimumRecommendedReps,
      this.maximumRecommendedReps,
      this.defaultRestSeconds,
      this.recommendedSetRangeMin,
      this.recommendedSetRangeMax,
      this.notes,
      required this.isCustom,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || dayType != null) {
      map['day_type'] =
          Variable<String>($ExercisesTable.$converterdayTypen.toSql(dayType));
    }
    map['tags'] = Variable<String>(tags);
    map['primary_muscle_group'] = Variable<String>(primaryMuscleGroup);
    map['secondary_muscle_groups'] = Variable<String>(secondaryMuscleGroups);
    map['movement_pattern'] = Variable<String>(movementPattern);
    {
      map['equipment_type'] = Variable<String>(
          $ExercisesTable.$converterequipmentType.toSql(equipmentType));
    }
    if (!nullToAbsent || exerciseCategory != null) {
      map['exercise_category'] = Variable<String>(
          $ExercisesTable.$converterexerciseCategoryn.toSql(exerciseCategory));
    }
    map['is_bodyweight'] = Variable<bool>(isBodyweight);
    map['is_unilateral'] = Variable<bool>(isUnilateral);
    if (!nullToAbsent || defaultIncrementKg != null) {
      map['default_increment_kg'] = Variable<double>(defaultIncrementKg);
    }
    if (!nullToAbsent || minimumRecommendedReps != null) {
      map['minimum_recommended_reps'] = Variable<int>(minimumRecommendedReps);
    }
    if (!nullToAbsent || maximumRecommendedReps != null) {
      map['maximum_recommended_reps'] = Variable<int>(maximumRecommendedReps);
    }
    if (!nullToAbsent || defaultRestSeconds != null) {
      map['default_rest_seconds'] = Variable<int>(defaultRestSeconds);
    }
    if (!nullToAbsent || recommendedSetRangeMin != null) {
      map['recommended_set_range_min'] = Variable<int>(recommendedSetRangeMin);
    }
    if (!nullToAbsent || recommendedSetRangeMax != null) {
      map['recommended_set_range_max'] = Variable<int>(recommendedSetRangeMax);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_custom'] = Variable<bool>(isCustom);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      name: Value(name),
      dayType: dayType == null && nullToAbsent
          ? const Value.absent()
          : Value(dayType),
      tags: Value(tags),
      primaryMuscleGroup: Value(primaryMuscleGroup),
      secondaryMuscleGroups: Value(secondaryMuscleGroups),
      movementPattern: Value(movementPattern),
      equipmentType: Value(equipmentType),
      exerciseCategory: exerciseCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseCategory),
      isBodyweight: Value(isBodyweight),
      isUnilateral: Value(isUnilateral),
      defaultIncrementKg: defaultIncrementKg == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultIncrementKg),
      minimumRecommendedReps: minimumRecommendedReps == null && nullToAbsent
          ? const Value.absent()
          : Value(minimumRecommendedReps),
      maximumRecommendedReps: maximumRecommendedReps == null && nullToAbsent
          ? const Value.absent()
          : Value(maximumRecommendedReps),
      defaultRestSeconds: defaultRestSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultRestSeconds),
      recommendedSetRangeMin: recommendedSetRangeMin == null && nullToAbsent
          ? const Value.absent()
          : Value(recommendedSetRangeMin),
      recommendedSetRangeMax: recommendedSetRangeMax == null && nullToAbsent
          ? const Value.absent()
          : Value(recommendedSetRangeMax),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      isCustom: Value(isCustom),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ExerciseRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      dayType: $ExercisesTable.$converterdayTypen
          .fromJson(serializer.fromJson<String?>(json['dayType'])),
      tags: serializer.fromJson<String>(json['tags']),
      primaryMuscleGroup:
          serializer.fromJson<String>(json['primaryMuscleGroup']),
      secondaryMuscleGroups:
          serializer.fromJson<String>(json['secondaryMuscleGroups']),
      movementPattern: serializer.fromJson<String>(json['movementPattern']),
      equipmentType: $ExercisesTable.$converterequipmentType
          .fromJson(serializer.fromJson<String>(json['equipmentType'])),
      exerciseCategory: $ExercisesTable.$converterexerciseCategoryn
          .fromJson(serializer.fromJson<String?>(json['exerciseCategory'])),
      isBodyweight: serializer.fromJson<bool>(json['isBodyweight']),
      isUnilateral: serializer.fromJson<bool>(json['isUnilateral']),
      defaultIncrementKg:
          serializer.fromJson<double?>(json['defaultIncrementKg']),
      minimumRecommendedReps:
          serializer.fromJson<int?>(json['minimumRecommendedReps']),
      maximumRecommendedReps:
          serializer.fromJson<int?>(json['maximumRecommendedReps']),
      defaultRestSeconds: serializer.fromJson<int?>(json['defaultRestSeconds']),
      recommendedSetRangeMin:
          serializer.fromJson<int?>(json['recommendedSetRangeMin']),
      recommendedSetRangeMax:
          serializer.fromJson<int?>(json['recommendedSetRangeMax']),
      notes: serializer.fromJson<String?>(json['notes']),
      isCustom: serializer.fromJson<bool>(json['isCustom']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'dayType': serializer
          .toJson<String?>($ExercisesTable.$converterdayTypen.toJson(dayType)),
      'tags': serializer.toJson<String>(tags),
      'primaryMuscleGroup': serializer.toJson<String>(primaryMuscleGroup),
      'secondaryMuscleGroups': serializer.toJson<String>(secondaryMuscleGroups),
      'movementPattern': serializer.toJson<String>(movementPattern),
      'equipmentType': serializer.toJson<String>(
          $ExercisesTable.$converterequipmentType.toJson(equipmentType)),
      'exerciseCategory': serializer.toJson<String?>(
          $ExercisesTable.$converterexerciseCategoryn.toJson(exerciseCategory)),
      'isBodyweight': serializer.toJson<bool>(isBodyweight),
      'isUnilateral': serializer.toJson<bool>(isUnilateral),
      'defaultIncrementKg': serializer.toJson<double?>(defaultIncrementKg),
      'minimumRecommendedReps': serializer.toJson<int?>(minimumRecommendedReps),
      'maximumRecommendedReps': serializer.toJson<int?>(maximumRecommendedReps),
      'defaultRestSeconds': serializer.toJson<int?>(defaultRestSeconds),
      'recommendedSetRangeMin': serializer.toJson<int?>(recommendedSetRangeMin),
      'recommendedSetRangeMax': serializer.toJson<int?>(recommendedSetRangeMax),
      'notes': serializer.toJson<String?>(notes),
      'isCustom': serializer.toJson<bool>(isCustom),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ExerciseRow copyWith(
          {String? id,
          String? name,
          Value<DayType?> dayType = const Value.absent(),
          String? tags,
          String? primaryMuscleGroup,
          String? secondaryMuscleGroups,
          String? movementPattern,
          EquipmentType? equipmentType,
          Value<ExerciseCategory?> exerciseCategory = const Value.absent(),
          bool? isBodyweight,
          bool? isUnilateral,
          Value<double?> defaultIncrementKg = const Value.absent(),
          Value<int?> minimumRecommendedReps = const Value.absent(),
          Value<int?> maximumRecommendedReps = const Value.absent(),
          Value<int?> defaultRestSeconds = const Value.absent(),
          Value<int?> recommendedSetRangeMin = const Value.absent(),
          Value<int?> recommendedSetRangeMax = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          bool? isCustom,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ExerciseRow(
        id: id ?? this.id,
        name: name ?? this.name,
        dayType: dayType.present ? dayType.value : this.dayType,
        tags: tags ?? this.tags,
        primaryMuscleGroup: primaryMuscleGroup ?? this.primaryMuscleGroup,
        secondaryMuscleGroups:
            secondaryMuscleGroups ?? this.secondaryMuscleGroups,
        movementPattern: movementPattern ?? this.movementPattern,
        equipmentType: equipmentType ?? this.equipmentType,
        exerciseCategory: exerciseCategory.present
            ? exerciseCategory.value
            : this.exerciseCategory,
        isBodyweight: isBodyweight ?? this.isBodyweight,
        isUnilateral: isUnilateral ?? this.isUnilateral,
        defaultIncrementKg: defaultIncrementKg.present
            ? defaultIncrementKg.value
            : this.defaultIncrementKg,
        minimumRecommendedReps: minimumRecommendedReps.present
            ? minimumRecommendedReps.value
            : this.minimumRecommendedReps,
        maximumRecommendedReps: maximumRecommendedReps.present
            ? maximumRecommendedReps.value
            : this.maximumRecommendedReps,
        defaultRestSeconds: defaultRestSeconds.present
            ? defaultRestSeconds.value
            : this.defaultRestSeconds,
        recommendedSetRangeMin: recommendedSetRangeMin.present
            ? recommendedSetRangeMin.value
            : this.recommendedSetRangeMin,
        recommendedSetRangeMax: recommendedSetRangeMax.present
            ? recommendedSetRangeMax.value
            : this.recommendedSetRangeMax,
        notes: notes.present ? notes.value : this.notes,
        isCustom: isCustom ?? this.isCustom,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ExerciseRow copyWithCompanion(ExercisesCompanion data) {
    return ExerciseRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      dayType: data.dayType.present ? data.dayType.value : this.dayType,
      tags: data.tags.present ? data.tags.value : this.tags,
      primaryMuscleGroup: data.primaryMuscleGroup.present
          ? data.primaryMuscleGroup.value
          : this.primaryMuscleGroup,
      secondaryMuscleGroups: data.secondaryMuscleGroups.present
          ? data.secondaryMuscleGroups.value
          : this.secondaryMuscleGroups,
      movementPattern: data.movementPattern.present
          ? data.movementPattern.value
          : this.movementPattern,
      equipmentType: data.equipmentType.present
          ? data.equipmentType.value
          : this.equipmentType,
      exerciseCategory: data.exerciseCategory.present
          ? data.exerciseCategory.value
          : this.exerciseCategory,
      isBodyweight: data.isBodyweight.present
          ? data.isBodyweight.value
          : this.isBodyweight,
      isUnilateral: data.isUnilateral.present
          ? data.isUnilateral.value
          : this.isUnilateral,
      defaultIncrementKg: data.defaultIncrementKg.present
          ? data.defaultIncrementKg.value
          : this.defaultIncrementKg,
      minimumRecommendedReps: data.minimumRecommendedReps.present
          ? data.minimumRecommendedReps.value
          : this.minimumRecommendedReps,
      maximumRecommendedReps: data.maximumRecommendedReps.present
          ? data.maximumRecommendedReps.value
          : this.maximumRecommendedReps,
      defaultRestSeconds: data.defaultRestSeconds.present
          ? data.defaultRestSeconds.value
          : this.defaultRestSeconds,
      recommendedSetRangeMin: data.recommendedSetRangeMin.present
          ? data.recommendedSetRangeMin.value
          : this.recommendedSetRangeMin,
      recommendedSetRangeMax: data.recommendedSetRangeMax.present
          ? data.recommendedSetRangeMax.value
          : this.recommendedSetRangeMax,
      notes: data.notes.present ? data.notes.value : this.notes,
      isCustom: data.isCustom.present ? data.isCustom.value : this.isCustom,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dayType: $dayType, ')
          ..write('tags: $tags, ')
          ..write('primaryMuscleGroup: $primaryMuscleGroup, ')
          ..write('secondaryMuscleGroups: $secondaryMuscleGroups, ')
          ..write('movementPattern: $movementPattern, ')
          ..write('equipmentType: $equipmentType, ')
          ..write('exerciseCategory: $exerciseCategory, ')
          ..write('isBodyweight: $isBodyweight, ')
          ..write('isUnilateral: $isUnilateral, ')
          ..write('defaultIncrementKg: $defaultIncrementKg, ')
          ..write('minimumRecommendedReps: $minimumRecommendedReps, ')
          ..write('maximumRecommendedReps: $maximumRecommendedReps, ')
          ..write('defaultRestSeconds: $defaultRestSeconds, ')
          ..write('recommendedSetRangeMin: $recommendedSetRangeMin, ')
          ..write('recommendedSetRangeMax: $recommendedSetRangeMax, ')
          ..write('notes: $notes, ')
          ..write('isCustom: $isCustom, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        name,
        dayType,
        tags,
        primaryMuscleGroup,
        secondaryMuscleGroups,
        movementPattern,
        equipmentType,
        exerciseCategory,
        isBodyweight,
        isUnilateral,
        defaultIncrementKg,
        minimumRecommendedReps,
        maximumRecommendedReps,
        defaultRestSeconds,
        recommendedSetRangeMin,
        recommendedSetRangeMax,
        notes,
        isCustom,
        createdAt,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.dayType == this.dayType &&
          other.tags == this.tags &&
          other.primaryMuscleGroup == this.primaryMuscleGroup &&
          other.secondaryMuscleGroups == this.secondaryMuscleGroups &&
          other.movementPattern == this.movementPattern &&
          other.equipmentType == this.equipmentType &&
          other.exerciseCategory == this.exerciseCategory &&
          other.isBodyweight == this.isBodyweight &&
          other.isUnilateral == this.isUnilateral &&
          other.defaultIncrementKg == this.defaultIncrementKg &&
          other.minimumRecommendedReps == this.minimumRecommendedReps &&
          other.maximumRecommendedReps == this.maximumRecommendedReps &&
          other.defaultRestSeconds == this.defaultRestSeconds &&
          other.recommendedSetRangeMin == this.recommendedSetRangeMin &&
          other.recommendedSetRangeMax == this.recommendedSetRangeMax &&
          other.notes == this.notes &&
          other.isCustom == this.isCustom &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExercisesCompanion extends UpdateCompanion<ExerciseRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<DayType?> dayType;
  final Value<String> tags;
  final Value<String> primaryMuscleGroup;
  final Value<String> secondaryMuscleGroups;
  final Value<String> movementPattern;
  final Value<EquipmentType> equipmentType;
  final Value<ExerciseCategory?> exerciseCategory;
  final Value<bool> isBodyweight;
  final Value<bool> isUnilateral;
  final Value<double?> defaultIncrementKg;
  final Value<int?> minimumRecommendedReps;
  final Value<int?> maximumRecommendedReps;
  final Value<int?> defaultRestSeconds;
  final Value<int?> recommendedSetRangeMin;
  final Value<int?> recommendedSetRangeMax;
  final Value<String?> notes;
  final Value<bool> isCustom;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.dayType = const Value.absent(),
    this.tags = const Value.absent(),
    this.primaryMuscleGroup = const Value.absent(),
    this.secondaryMuscleGroups = const Value.absent(),
    this.movementPattern = const Value.absent(),
    this.equipmentType = const Value.absent(),
    this.exerciseCategory = const Value.absent(),
    this.isBodyweight = const Value.absent(),
    this.isUnilateral = const Value.absent(),
    this.defaultIncrementKg = const Value.absent(),
    this.minimumRecommendedReps = const Value.absent(),
    this.maximumRecommendedReps = const Value.absent(),
    this.defaultRestSeconds = const Value.absent(),
    this.recommendedSetRangeMin = const Value.absent(),
    this.recommendedSetRangeMax = const Value.absent(),
    this.notes = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExercisesCompanion.insert({
    required String id,
    required String name,
    this.dayType = const Value.absent(),
    this.tags = const Value.absent(),
    required String primaryMuscleGroup,
    this.secondaryMuscleGroups = const Value.absent(),
    this.movementPattern = const Value.absent(),
    required EquipmentType equipmentType,
    this.exerciseCategory = const Value.absent(),
    this.isBodyweight = const Value.absent(),
    this.isUnilateral = const Value.absent(),
    this.defaultIncrementKg = const Value.absent(),
    this.minimumRecommendedReps = const Value.absent(),
    this.maximumRecommendedReps = const Value.absent(),
    this.defaultRestSeconds = const Value.absent(),
    this.recommendedSetRangeMin = const Value.absent(),
    this.recommendedSetRangeMax = const Value.absent(),
    this.notes = const Value.absent(),
    this.isCustom = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        primaryMuscleGroup = Value(primaryMuscleGroup),
        equipmentType = Value(equipmentType),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<ExerciseRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? dayType,
    Expression<String>? tags,
    Expression<String>? primaryMuscleGroup,
    Expression<String>? secondaryMuscleGroups,
    Expression<String>? movementPattern,
    Expression<String>? equipmentType,
    Expression<String>? exerciseCategory,
    Expression<bool>? isBodyweight,
    Expression<bool>? isUnilateral,
    Expression<double>? defaultIncrementKg,
    Expression<int>? minimumRecommendedReps,
    Expression<int>? maximumRecommendedReps,
    Expression<int>? defaultRestSeconds,
    Expression<int>? recommendedSetRangeMin,
    Expression<int>? recommendedSetRangeMax,
    Expression<String>? notes,
    Expression<bool>? isCustom,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (dayType != null) 'day_type': dayType,
      if (tags != null) 'tags': tags,
      if (primaryMuscleGroup != null)
        'primary_muscle_group': primaryMuscleGroup,
      if (secondaryMuscleGroups != null)
        'secondary_muscle_groups': secondaryMuscleGroups,
      if (movementPattern != null) 'movement_pattern': movementPattern,
      if (equipmentType != null) 'equipment_type': equipmentType,
      if (exerciseCategory != null) 'exercise_category': exerciseCategory,
      if (isBodyweight != null) 'is_bodyweight': isBodyweight,
      if (isUnilateral != null) 'is_unilateral': isUnilateral,
      if (defaultIncrementKg != null)
        'default_increment_kg': defaultIncrementKg,
      if (minimumRecommendedReps != null)
        'minimum_recommended_reps': minimumRecommendedReps,
      if (maximumRecommendedReps != null)
        'maximum_recommended_reps': maximumRecommendedReps,
      if (defaultRestSeconds != null)
        'default_rest_seconds': defaultRestSeconds,
      if (recommendedSetRangeMin != null)
        'recommended_set_range_min': recommendedSetRangeMin,
      if (recommendedSetRangeMax != null)
        'recommended_set_range_max': recommendedSetRangeMax,
      if (notes != null) 'notes': notes,
      if (isCustom != null) 'is_custom': isCustom,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExercisesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<DayType?>? dayType,
      Value<String>? tags,
      Value<String>? primaryMuscleGroup,
      Value<String>? secondaryMuscleGroups,
      Value<String>? movementPattern,
      Value<EquipmentType>? equipmentType,
      Value<ExerciseCategory?>? exerciseCategory,
      Value<bool>? isBodyweight,
      Value<bool>? isUnilateral,
      Value<double?>? defaultIncrementKg,
      Value<int?>? minimumRecommendedReps,
      Value<int?>? maximumRecommendedReps,
      Value<int?>? defaultRestSeconds,
      Value<int?>? recommendedSetRangeMin,
      Value<int?>? recommendedSetRangeMax,
      Value<String?>? notes,
      Value<bool>? isCustom,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      dayType: dayType ?? this.dayType,
      tags: tags ?? this.tags,
      primaryMuscleGroup: primaryMuscleGroup ?? this.primaryMuscleGroup,
      secondaryMuscleGroups:
          secondaryMuscleGroups ?? this.secondaryMuscleGroups,
      movementPattern: movementPattern ?? this.movementPattern,
      equipmentType: equipmentType ?? this.equipmentType,
      exerciseCategory: exerciseCategory ?? this.exerciseCategory,
      isBodyweight: isBodyweight ?? this.isBodyweight,
      isUnilateral: isUnilateral ?? this.isUnilateral,
      defaultIncrementKg: defaultIncrementKg ?? this.defaultIncrementKg,
      minimumRecommendedReps:
          minimumRecommendedReps ?? this.minimumRecommendedReps,
      maximumRecommendedReps:
          maximumRecommendedReps ?? this.maximumRecommendedReps,
      defaultRestSeconds: defaultRestSeconds ?? this.defaultRestSeconds,
      recommendedSetRangeMin:
          recommendedSetRangeMin ?? this.recommendedSetRangeMin,
      recommendedSetRangeMax:
          recommendedSetRangeMax ?? this.recommendedSetRangeMax,
      notes: notes ?? this.notes,
      isCustom: isCustom ?? this.isCustom,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dayType.present) {
      map['day_type'] = Variable<String>(
          $ExercisesTable.$converterdayTypen.toSql(dayType.value));
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (primaryMuscleGroup.present) {
      map['primary_muscle_group'] = Variable<String>(primaryMuscleGroup.value);
    }
    if (secondaryMuscleGroups.present) {
      map['secondary_muscle_groups'] =
          Variable<String>(secondaryMuscleGroups.value);
    }
    if (movementPattern.present) {
      map['movement_pattern'] = Variable<String>(movementPattern.value);
    }
    if (equipmentType.present) {
      map['equipment_type'] = Variable<String>(
          $ExercisesTable.$converterequipmentType.toSql(equipmentType.value));
    }
    if (exerciseCategory.present) {
      map['exercise_category'] = Variable<String>($ExercisesTable
          .$converterexerciseCategoryn
          .toSql(exerciseCategory.value));
    }
    if (isBodyweight.present) {
      map['is_bodyweight'] = Variable<bool>(isBodyweight.value);
    }
    if (isUnilateral.present) {
      map['is_unilateral'] = Variable<bool>(isUnilateral.value);
    }
    if (defaultIncrementKg.present) {
      map['default_increment_kg'] = Variable<double>(defaultIncrementKg.value);
    }
    if (minimumRecommendedReps.present) {
      map['minimum_recommended_reps'] =
          Variable<int>(minimumRecommendedReps.value);
    }
    if (maximumRecommendedReps.present) {
      map['maximum_recommended_reps'] =
          Variable<int>(maximumRecommendedReps.value);
    }
    if (defaultRestSeconds.present) {
      map['default_rest_seconds'] = Variable<int>(defaultRestSeconds.value);
    }
    if (recommendedSetRangeMin.present) {
      map['recommended_set_range_min'] =
          Variable<int>(recommendedSetRangeMin.value);
    }
    if (recommendedSetRangeMax.present) {
      map['recommended_set_range_max'] =
          Variable<int>(recommendedSetRangeMax.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isCustom.present) {
      map['is_custom'] = Variable<bool>(isCustom.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dayType: $dayType, ')
          ..write('tags: $tags, ')
          ..write('primaryMuscleGroup: $primaryMuscleGroup, ')
          ..write('secondaryMuscleGroups: $secondaryMuscleGroups, ')
          ..write('movementPattern: $movementPattern, ')
          ..write('equipmentType: $equipmentType, ')
          ..write('exerciseCategory: $exerciseCategory, ')
          ..write('isBodyweight: $isBodyweight, ')
          ..write('isUnilateral: $isUnilateral, ')
          ..write('defaultIncrementKg: $defaultIncrementKg, ')
          ..write('minimumRecommendedReps: $minimumRecommendedReps, ')
          ..write('maximumRecommendedReps: $maximumRecommendedReps, ')
          ..write('defaultRestSeconds: $defaultRestSeconds, ')
          ..write('recommendedSetRangeMin: $recommendedSetRangeMin, ')
          ..write('recommendedSetRangeMax: $recommendedSetRangeMax, ')
          ..write('notes: $notes, ')
          ..write('isCustom: $isCustom, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSessionsTable extends WorkoutSessions
    with TableInfo<$WorkoutSessionsTable, WorkoutSessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userProfileIdMeta =
      const VerificationMeta('userProfileId');
  @override
  late final GeneratedColumn<String> userProfileId = GeneratedColumn<String>(
      'user_profile_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<DayType?, String> dayType =
      GeneratedColumn<String>('day_type', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<DayType?>($WorkoutSessionsTable.$converterdayTypen);
  static const VerificationMeta _sessionNameMeta =
      const VerificationMeta('sessionName');
  @override
  late final GeneratedColumn<String> sessionName = GeneratedColumn<String>(
      'session_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endedAtMeta =
      const VerificationMeta('endedAt');
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
      'ended_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastActivityAtMeta =
      const VerificationMeta('lastActivityAt');
  @override
  late final GeneratedColumn<DateTime> lastActivityAt =
      GeneratedColumn<DateTime>('last_activity_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<WorkoutSessionStatus, String>
      status = GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<WorkoutSessionStatus>(
              $WorkoutSessionsTable.$converterstatus);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userProfileId,
        dayType,
        sessionName,
        tags,
        startedAt,
        endedAt,
        lastActivityAt,
        status,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutSessionRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_profile_id')) {
      context.handle(
          _userProfileIdMeta,
          userProfileId.isAcceptableOrUnknown(
              data['user_profile_id']!, _userProfileIdMeta));
    } else if (isInserting) {
      context.missing(_userProfileIdMeta);
    }
    if (data.containsKey('session_name')) {
      context.handle(
          _sessionNameMeta,
          sessionName.isAcceptableOrUnknown(
              data['session_name']!, _sessionNameMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(_endedAtMeta,
          endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta));
    }
    if (data.containsKey('last_activity_at')) {
      context.handle(
          _lastActivityAtMeta,
          lastActivityAt.isAcceptableOrUnknown(
              data['last_activity_at']!, _lastActivityAtMeta));
    } else if (isInserting) {
      context.missing(_lastActivityAtMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSessionRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userProfileId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}user_profile_id'])!,
      dayType: $WorkoutSessionsTable.$converterdayTypen.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}day_type'])),
      sessionName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_name']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      endedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}ended_at']),
      lastActivityAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_activity_at'])!,
      status: $WorkoutSessionsTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $WorkoutSessionsTable createAlias(String alias) {
    return $WorkoutSessionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DayType, String, String> $converterdayType =
      const EnumNameConverter<DayType>(DayType.values);
  static JsonTypeConverter2<DayType?, String?, String?> $converterdayTypen =
      JsonTypeConverter2.asNullable($converterdayType);
  static JsonTypeConverter2<WorkoutSessionStatus, String, String>
      $converterstatus = const EnumNameConverter<WorkoutSessionStatus>(
          WorkoutSessionStatus.values);
}

class WorkoutSessionRow extends DataClass
    implements Insertable<WorkoutSessionRow> {
  final String id;
  final String userProfileId;
  final DayType? dayType;
  final String? sessionName;
  final String tags;
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime lastActivityAt;
  final WorkoutSessionStatus status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WorkoutSessionRow(
      {required this.id,
      required this.userProfileId,
      this.dayType,
      this.sessionName,
      required this.tags,
      required this.startedAt,
      this.endedAt,
      required this.lastActivityAt,
      required this.status,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_profile_id'] = Variable<String>(userProfileId);
    if (!nullToAbsent || dayType != null) {
      map['day_type'] = Variable<String>(
          $WorkoutSessionsTable.$converterdayTypen.toSql(dayType));
    }
    if (!nullToAbsent || sessionName != null) {
      map['session_name'] = Variable<String>(sessionName);
    }
    map['tags'] = Variable<String>(tags);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['last_activity_at'] = Variable<DateTime>(lastActivityAt);
    {
      map['status'] = Variable<String>(
          $WorkoutSessionsTable.$converterstatus.toSql(status));
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WorkoutSessionsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSessionsCompanion(
      id: Value(id),
      userProfileId: Value(userProfileId),
      dayType: dayType == null && nullToAbsent
          ? const Value.absent()
          : Value(dayType),
      sessionName: sessionName == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionName),
      tags: Value(tags),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      lastActivityAt: Value(lastActivityAt),
      status: Value(status),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WorkoutSessionRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSessionRow(
      id: serializer.fromJson<String>(json['id']),
      userProfileId: serializer.fromJson<String>(json['userProfileId']),
      dayType: $WorkoutSessionsTable.$converterdayTypen
          .fromJson(serializer.fromJson<String?>(json['dayType'])),
      sessionName: serializer.fromJson<String?>(json['sessionName']),
      tags: serializer.fromJson<String>(json['tags']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      lastActivityAt: serializer.fromJson<DateTime>(json['lastActivityAt']),
      status: $WorkoutSessionsTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userProfileId': serializer.toJson<String>(userProfileId),
      'dayType': serializer.toJson<String?>(
          $WorkoutSessionsTable.$converterdayTypen.toJson(dayType)),
      'sessionName': serializer.toJson<String?>(sessionName),
      'tags': serializer.toJson<String>(tags),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'lastActivityAt': serializer.toJson<DateTime>(lastActivityAt),
      'status': serializer.toJson<String>(
          $WorkoutSessionsTable.$converterstatus.toJson(status)),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WorkoutSessionRow copyWith(
          {String? id,
          String? userProfileId,
          Value<DayType?> dayType = const Value.absent(),
          Value<String?> sessionName = const Value.absent(),
          String? tags,
          DateTime? startedAt,
          Value<DateTime?> endedAt = const Value.absent(),
          DateTime? lastActivityAt,
          WorkoutSessionStatus? status,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      WorkoutSessionRow(
        id: id ?? this.id,
        userProfileId: userProfileId ?? this.userProfileId,
        dayType: dayType.present ? dayType.value : this.dayType,
        sessionName: sessionName.present ? sessionName.value : this.sessionName,
        tags: tags ?? this.tags,
        startedAt: startedAt ?? this.startedAt,
        endedAt: endedAt.present ? endedAt.value : this.endedAt,
        lastActivityAt: lastActivityAt ?? this.lastActivityAt,
        status: status ?? this.status,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  WorkoutSessionRow copyWithCompanion(WorkoutSessionsCompanion data) {
    return WorkoutSessionRow(
      id: data.id.present ? data.id.value : this.id,
      userProfileId: data.userProfileId.present
          ? data.userProfileId.value
          : this.userProfileId,
      dayType: data.dayType.present ? data.dayType.value : this.dayType,
      sessionName:
          data.sessionName.present ? data.sessionName.value : this.sessionName,
      tags: data.tags.present ? data.tags.value : this.tags,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      lastActivityAt: data.lastActivityAt.present
          ? data.lastActivityAt.value
          : this.lastActivityAt,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionRow(')
          ..write('id: $id, ')
          ..write('userProfileId: $userProfileId, ')
          ..write('dayType: $dayType, ')
          ..write('sessionName: $sessionName, ')
          ..write('tags: $tags, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('lastActivityAt: $lastActivityAt, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userProfileId, dayType, sessionName, tags,
      startedAt, endedAt, lastActivityAt, status, notes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSessionRow &&
          other.id == this.id &&
          other.userProfileId == this.userProfileId &&
          other.dayType == this.dayType &&
          other.sessionName == this.sessionName &&
          other.tags == this.tags &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.lastActivityAt == this.lastActivityAt &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkoutSessionsCompanion extends UpdateCompanion<WorkoutSessionRow> {
  final Value<String> id;
  final Value<String> userProfileId;
  final Value<DayType?> dayType;
  final Value<String?> sessionName;
  final Value<String> tags;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<DateTime> lastActivityAt;
  final Value<WorkoutSessionStatus> status;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WorkoutSessionsCompanion({
    this.id = const Value.absent(),
    this.userProfileId = const Value.absent(),
    this.dayType = const Value.absent(),
    this.sessionName = const Value.absent(),
    this.tags = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.lastActivityAt = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutSessionsCompanion.insert({
    required String id,
    required String userProfileId,
    this.dayType = const Value.absent(),
    this.sessionName = const Value.absent(),
    this.tags = const Value.absent(),
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    required DateTime lastActivityAt,
    required WorkoutSessionStatus status,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userProfileId = Value(userProfileId),
        startedAt = Value(startedAt),
        lastActivityAt = Value(lastActivityAt),
        status = Value(status),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<WorkoutSessionRow> custom({
    Expression<String>? id,
    Expression<String>? userProfileId,
    Expression<String>? dayType,
    Expression<String>? sessionName,
    Expression<String>? tags,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<DateTime>? lastActivityAt,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userProfileId != null) 'user_profile_id': userProfileId,
      if (dayType != null) 'day_type': dayType,
      if (sessionName != null) 'session_name': sessionName,
      if (tags != null) 'tags': tags,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (lastActivityAt != null) 'last_activity_at': lastActivityAt,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutSessionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userProfileId,
      Value<DayType?>? dayType,
      Value<String?>? sessionName,
      Value<String>? tags,
      Value<DateTime>? startedAt,
      Value<DateTime?>? endedAt,
      Value<DateTime>? lastActivityAt,
      Value<WorkoutSessionStatus>? status,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return WorkoutSessionsCompanion(
      id: id ?? this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      dayType: dayType ?? this.dayType,
      sessionName: sessionName ?? this.sessionName,
      tags: tags ?? this.tags,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      lastActivityAt: lastActivityAt ?? this.lastActivityAt,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userProfileId.present) {
      map['user_profile_id'] = Variable<String>(userProfileId.value);
    }
    if (dayType.present) {
      map['day_type'] = Variable<String>(
          $WorkoutSessionsTable.$converterdayTypen.toSql(dayType.value));
    }
    if (sessionName.present) {
      map['session_name'] = Variable<String>(sessionName.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (lastActivityAt.present) {
      map['last_activity_at'] = Variable<DateTime>(lastActivityAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $WorkoutSessionsTable.$converterstatus.toSql(status.value));
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsCompanion(')
          ..write('id: $id, ')
          ..write('userProfileId: $userProfileId, ')
          ..write('dayType: $dayType, ')
          ..write('sessionName: $sessionName, ')
          ..write('tags: $tags, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('lastActivityAt: $lastActivityAt, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutExercisesTable extends WorkoutExercises
    with TableInfo<$WorkoutExercisesTable, WorkoutExerciseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exerciseIdMeta =
      const VerificationMeta('exerciseId');
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
      'exercise_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _endedAtMeta =
      const VerificationMeta('endedAt');
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
      'ended_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sessionId, exerciseId, orderIndex, startedAt, endedAt, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_exercises';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutExerciseRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id']!, _exerciseIdMeta));
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    }
    if (data.containsKey('ended_at')) {
      context.handle(_endedAtMeta,
          endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutExerciseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutExerciseRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id'])!,
      exerciseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_id'])!,
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at']),
      endedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}ended_at']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $WorkoutExercisesTable createAlias(String alias) {
    return $WorkoutExercisesTable(attachedDatabase, alias);
  }
}

class WorkoutExerciseRow extends DataClass
    implements Insertable<WorkoutExerciseRow> {
  final String id;
  final String sessionId;
  final String exerciseId;
  final int orderIndex;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final String? notes;
  const WorkoutExerciseRow(
      {required this.id,
      required this.sessionId,
      required this.exerciseId,
      required this.orderIndex,
      this.startedAt,
      this.endedAt,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['order_index'] = Variable<int>(orderIndex);
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  WorkoutExercisesCompanion toCompanion(bool nullToAbsent) {
    return WorkoutExercisesCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      exerciseId: Value(exerciseId),
      orderIndex: Value(orderIndex),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory WorkoutExerciseRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutExerciseRow(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  WorkoutExerciseRow copyWith(
          {String? id,
          String? sessionId,
          String? exerciseId,
          int? orderIndex,
          Value<DateTime?> startedAt = const Value.absent(),
          Value<DateTime?> endedAt = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      WorkoutExerciseRow(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        exerciseId: exerciseId ?? this.exerciseId,
        orderIndex: orderIndex ?? this.orderIndex,
        startedAt: startedAt.present ? startedAt.value : this.startedAt,
        endedAt: endedAt.present ? endedAt.value : this.endedAt,
        notes: notes.present ? notes.value : this.notes,
      );
  WorkoutExerciseRow copyWithCompanion(WorkoutExercisesCompanion data) {
    return WorkoutExerciseRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      exerciseId:
          data.exerciseId.present ? data.exerciseId.value : this.exerciseId,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutExerciseRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, sessionId, exerciseId, orderIndex, startedAt, endedAt, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutExerciseRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.exerciseId == this.exerciseId &&
          other.orderIndex == this.orderIndex &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.notes == this.notes);
}

class WorkoutExercisesCompanion extends UpdateCompanion<WorkoutExerciseRow> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> exerciseId;
  final Value<int> orderIndex;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> endedAt;
  final Value<String?> notes;
  final Value<int> rowid;
  const WorkoutExercisesCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutExercisesCompanion.insert({
    required String id,
    required String sessionId,
    required String exerciseId,
    required int orderIndex,
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sessionId = Value(sessionId),
        exerciseId = Value(exerciseId),
        orderIndex = Value(orderIndex);
  static Insertable<WorkoutExerciseRow> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? exerciseId,
    Expression<int>? orderIndex,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (orderIndex != null) 'order_index': orderIndex,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutExercisesCompanion copyWith(
      {Value<String>? id,
      Value<String>? sessionId,
      Value<String>? exerciseId,
      Value<int>? orderIndex,
      Value<DateTime?>? startedAt,
      Value<DateTime?>? endedAt,
      Value<String?>? notes,
      Value<int>? rowid}) {
    return WorkoutExercisesCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      exerciseId: exerciseId ?? this.exerciseId,
      orderIndex: orderIndex ?? this.orderIndex,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutExercisesCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSetsTable extends WorkoutSets
    with TableInfo<$WorkoutSetsTable, WorkoutSetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workoutExerciseIdMeta =
      const VerificationMeta('workoutExerciseId');
  @override
  late final GeneratedColumn<String> workoutExerciseId =
      GeneratedColumn<String>('workout_exercise_id', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _setNumberMeta =
      const VerificationMeta('setNumber');
  @override
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
      'set_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _loadTypeMeta = const VerificationMeta('loadType');
  @override
  late final GeneratedColumnWithTypeConverter<WorkoutSetLoadType, String>
      loadType = GeneratedColumn<String>('load_type', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(WorkoutSetLoadType.externalLoad.name))
          .withConverter<WorkoutSetLoadType>(
              $WorkoutSetsTable.$converterloadType);
  static const VerificationMeta _rpeMeta = const VerificationMeta('rpe');
  @override
  late final GeneratedColumn<double> rpe = GeneratedColumn<double>(
      'rpe', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _rirMeta = const VerificationMeta('rir');
  @override
  late final GeneratedColumn<int> rir = GeneratedColumn<int>(
      'rir', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isWarmupMeta =
      const VerificationMeta('isWarmup');
  @override
  late final GeneratedColumn<bool> isWarmup = GeneratedColumn<bool>(
      'is_warmup', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_warmup" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isFailureMeta =
      const VerificationMeta('isFailure');
  @override
  late final GeneratedColumn<bool> isFailure = GeneratedColumn<bool>(
      'is_failure', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_failure" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _estimatedOneRepMaxKgMeta =
      const VerificationMeta('estimatedOneRepMaxKg');
  @override
  late final GeneratedColumn<double> estimatedOneRepMaxKg =
      GeneratedColumn<double>('estimated_one_rep_max_kg', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _restBeforeSetSecondsMeta =
      const VerificationMeta('restBeforeSetSeconds');
  @override
  late final GeneratedColumn<int> restBeforeSetSeconds = GeneratedColumn<int>(
      'rest_before_set_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _restAfterSetSecondsMeta =
      const VerificationMeta('restAfterSetSeconds');
  @override
  late final GeneratedColumn<int> restAfterSetSeconds = GeneratedColumn<int>(
      'rest_after_set_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        workoutExerciseId,
        setNumber,
        weightKg,
        reps,
        loadType,
        rpe,
        rir,
        isWarmup,
        isFailure,
        estimatedOneRepMaxKg,
        restBeforeSetSeconds,
        restAfterSetSeconds,
        startedAt,
        completedAt,
        createdAt,
        updatedAt,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sets';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutSetRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workout_exercise_id')) {
      context.handle(
          _workoutExerciseIdMeta,
          workoutExerciseId.isAcceptableOrUnknown(
              data['workout_exercise_id']!, _workoutExerciseIdMeta));
    } else if (isInserting) {
      context.missing(_workoutExerciseIdMeta);
    }
    if (data.containsKey('set_number')) {
      context.handle(_setNumberMeta,
          setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta));
    } else if (isInserting) {
      context.missing(_setNumberMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('load_type')) {
      context.handle(_loadTypeMeta,
          loadType.isAcceptableOrUnknown(data['load_type']!, _loadTypeMeta));
    }
    if (data.containsKey('rpe')) {
      context.handle(
          _rpeMeta, rpe.isAcceptableOrUnknown(data['rpe']!, _rpeMeta));
    }
    if (data.containsKey('rir')) {
      context.handle(
          _rirMeta, rir.isAcceptableOrUnknown(data['rir']!, _rirMeta));
    }
    if (data.containsKey('is_warmup')) {
      context.handle(_isWarmupMeta,
          isWarmup.isAcceptableOrUnknown(data['is_warmup']!, _isWarmupMeta));
    }
    if (data.containsKey('is_failure')) {
      context.handle(_isFailureMeta,
          isFailure.isAcceptableOrUnknown(data['is_failure']!, _isFailureMeta));
    }
    if (data.containsKey('estimated_one_rep_max_kg')) {
      context.handle(
          _estimatedOneRepMaxKgMeta,
          estimatedOneRepMaxKg.isAcceptableOrUnknown(
              data['estimated_one_rep_max_kg']!, _estimatedOneRepMaxKgMeta));
    }
    if (data.containsKey('rest_before_set_seconds')) {
      context.handle(
          _restBeforeSetSecondsMeta,
          restBeforeSetSeconds.isAcceptableOrUnknown(
              data['rest_before_set_seconds']!, _restBeforeSetSecondsMeta));
    }
    if (data.containsKey('rest_after_set_seconds')) {
      context.handle(
          _restAfterSetSecondsMeta,
          restAfterSetSeconds.isAcceptableOrUnknown(
              data['rest_after_set_seconds']!, _restAfterSetSecondsMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSetRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workoutExerciseId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}workout_exercise_id'])!,
      setNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}set_number'])!,
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg'])!,
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reps'])!,
      loadType: $WorkoutSetsTable.$converterloadType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}load_type'])!),
      rpe: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rpe']),
      rir: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rir']),
      isWarmup: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_warmup'])!,
      isFailure: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_failure'])!,
      estimatedOneRepMaxKg: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}estimated_one_rep_max_kg']),
      restBeforeSetSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}rest_before_set_seconds']),
      restAfterSetSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}rest_after_set_seconds']),
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at']),
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  static JsonTypeConverter2<WorkoutSetLoadType, String, String>
      $converterloadType = const EnumNameConverter<WorkoutSetLoadType>(
          WorkoutSetLoadType.values);

  @override
  $WorkoutSetsTable createAlias(String alias) {
    return $WorkoutSetsTable(attachedDatabase, alias);
  }
}

class WorkoutSetRow extends DataClass implements Insertable<WorkoutSetRow> {
  final String id;
  final String workoutExerciseId;
  final int setNumber;
  final double weightKg;
  final int reps;
  final WorkoutSetLoadType loadType;
  final double? rpe;
  final int? rir;
  final bool isWarmup;
  final bool isFailure;
  final double? estimatedOneRepMaxKg;
  final int? restBeforeSetSeconds;
  final int? restAfterSetSeconds;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? notes;
  const WorkoutSetRow(
      {required this.id,
      required this.workoutExerciseId,
      required this.setNumber,
      required this.weightKg,
      required this.reps,
      this.loadType = WorkoutSetLoadType.externalLoad,
      this.rpe,
      this.rir,
      required this.isWarmup,
      required this.isFailure,
      this.estimatedOneRepMaxKg,
      this.restBeforeSetSeconds,
      this.restAfterSetSeconds,
      this.startedAt,
      this.completedAt,
      required this.createdAt,
      required this.updatedAt,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workout_exercise_id'] = Variable<String>(workoutExerciseId);
    map['set_number'] = Variable<int>(setNumber);
    map['weight_kg'] = Variable<double>(weightKg);
    map['reps'] = Variable<int>(reps);
    map['load_type'] = Variable<String>(
        $WorkoutSetsTable.$converterloadType.toSql(loadType));
    if (!nullToAbsent || rpe != null) {
      map['rpe'] = Variable<double>(rpe);
    }
    if (!nullToAbsent || rir != null) {
      map['rir'] = Variable<int>(rir);
    }
    map['is_warmup'] = Variable<bool>(isWarmup);
    map['is_failure'] = Variable<bool>(isFailure);
    if (!nullToAbsent || estimatedOneRepMaxKg != null) {
      map['estimated_one_rep_max_kg'] = Variable<double>(estimatedOneRepMaxKg);
    }
    if (!nullToAbsent || restBeforeSetSeconds != null) {
      map['rest_before_set_seconds'] = Variable<int>(restBeforeSetSeconds);
    }
    if (!nullToAbsent || restAfterSetSeconds != null) {
      map['rest_after_set_seconds'] = Variable<int>(restAfterSetSeconds);
    }
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  WorkoutSetsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSetsCompanion(
      id: Value(id),
      workoutExerciseId: Value(workoutExerciseId),
      setNumber: Value(setNumber),
      weightKg: Value(weightKg),
      reps: Value(reps),
      loadType: Value(loadType),
      rpe: rpe == null && nullToAbsent ? const Value.absent() : Value(rpe),
      rir: rir == null && nullToAbsent ? const Value.absent() : Value(rir),
      isWarmup: Value(isWarmup),
      isFailure: Value(isFailure),
      estimatedOneRepMaxKg: estimatedOneRepMaxKg == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedOneRepMaxKg),
      restBeforeSetSeconds: restBeforeSetSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(restBeforeSetSeconds),
      restAfterSetSeconds: restAfterSetSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(restAfterSetSeconds),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory WorkoutSetRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSetRow(
      id: serializer.fromJson<String>(json['id']),
      workoutExerciseId: serializer.fromJson<String>(json['workoutExerciseId']),
      setNumber: serializer.fromJson<int>(json['setNumber']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      reps: serializer.fromJson<int>(json['reps']),
      loadType: serializer.fromJson<WorkoutSetLoadType>(json['loadType']),
      rpe: serializer.fromJson<double?>(json['rpe']),
      rir: serializer.fromJson<int?>(json['rir']),
      isWarmup: serializer.fromJson<bool>(json['isWarmup']),
      isFailure: serializer.fromJson<bool>(json['isFailure']),
      estimatedOneRepMaxKg:
          serializer.fromJson<double?>(json['estimatedOneRepMaxKg']),
      restBeforeSetSeconds:
          serializer.fromJson<int?>(json['restBeforeSetSeconds']),
      restAfterSetSeconds:
          serializer.fromJson<int?>(json['restAfterSetSeconds']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workoutExerciseId': serializer.toJson<String>(workoutExerciseId),
      'setNumber': serializer.toJson<int>(setNumber),
      'weightKg': serializer.toJson<double>(weightKg),
      'reps': serializer.toJson<int>(reps),
      'loadType': serializer.toJson<WorkoutSetLoadType>(loadType),
      'rpe': serializer.toJson<double?>(rpe),
      'rir': serializer.toJson<int?>(rir),
      'isWarmup': serializer.toJson<bool>(isWarmup),
      'isFailure': serializer.toJson<bool>(isFailure),
      'estimatedOneRepMaxKg': serializer.toJson<double?>(estimatedOneRepMaxKg),
      'restBeforeSetSeconds': serializer.toJson<int?>(restBeforeSetSeconds),
      'restAfterSetSeconds': serializer.toJson<int?>(restAfterSetSeconds),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  WorkoutSetRow copyWith(
          {String? id,
          String? workoutExerciseId,
          int? setNumber,
          double? weightKg,
          int? reps,
          WorkoutSetLoadType? loadType,
          Value<double?> rpe = const Value.absent(),
          Value<int?> rir = const Value.absent(),
          bool? isWarmup,
          bool? isFailure,
          Value<double?> estimatedOneRepMaxKg = const Value.absent(),
          Value<int?> restBeforeSetSeconds = const Value.absent(),
          Value<int?> restAfterSetSeconds = const Value.absent(),
          Value<DateTime?> startedAt = const Value.absent(),
          Value<DateTime?> completedAt = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<String?> notes = const Value.absent()}) =>
      WorkoutSetRow(
        id: id ?? this.id,
        workoutExerciseId: workoutExerciseId ?? this.workoutExerciseId,
        setNumber: setNumber ?? this.setNumber,
        weightKg: weightKg ?? this.weightKg,
        reps: reps ?? this.reps,
        loadType: loadType ?? this.loadType,
        rpe: rpe.present ? rpe.value : this.rpe,
        rir: rir.present ? rir.value : this.rir,
        isWarmup: isWarmup ?? this.isWarmup,
        isFailure: isFailure ?? this.isFailure,
        estimatedOneRepMaxKg: estimatedOneRepMaxKg.present
            ? estimatedOneRepMaxKg.value
            : this.estimatedOneRepMaxKg,
        restBeforeSetSeconds: restBeforeSetSeconds.present
            ? restBeforeSetSeconds.value
            : this.restBeforeSetSeconds,
        restAfterSetSeconds: restAfterSetSeconds.present
            ? restAfterSetSeconds.value
            : this.restAfterSetSeconds,
        startedAt: startedAt.present ? startedAt.value : this.startedAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        notes: notes.present ? notes.value : this.notes,
      );
  WorkoutSetRow copyWithCompanion(WorkoutSetsCompanion data) {
    return WorkoutSetRow(
      id: data.id.present ? data.id.value : this.id,
      workoutExerciseId: data.workoutExerciseId.present
          ? data.workoutExerciseId.value
          : this.workoutExerciseId,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      reps: data.reps.present ? data.reps.value : this.reps,
      loadType: data.loadType.present ? data.loadType.value : this.loadType,
      rpe: data.rpe.present ? data.rpe.value : this.rpe,
      rir: data.rir.present ? data.rir.value : this.rir,
      isWarmup: data.isWarmup.present ? data.isWarmup.value : this.isWarmup,
      isFailure: data.isFailure.present ? data.isFailure.value : this.isFailure,
      estimatedOneRepMaxKg: data.estimatedOneRepMaxKg.present
          ? data.estimatedOneRepMaxKg.value
          : this.estimatedOneRepMaxKg,
      restBeforeSetSeconds: data.restBeforeSetSeconds.present
          ? data.restBeforeSetSeconds.value
          : this.restBeforeSetSeconds,
      restAfterSetSeconds: data.restAfterSetSeconds.present
          ? data.restAfterSetSeconds.value
          : this.restAfterSetSeconds,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSetRow(')
          ..write('id: $id, ')
          ..write('workoutExerciseId: $workoutExerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('weightKg: $weightKg, ')
          ..write('reps: $reps, ')
          ..write('loadType: $loadType, ')
          ..write('rpe: $rpe, ')
          ..write('rir: $rir, ')
          ..write('isWarmup: $isWarmup, ')
          ..write('isFailure: $isFailure, ')
          ..write('estimatedOneRepMaxKg: $estimatedOneRepMaxKg, ')
          ..write('restBeforeSetSeconds: $restBeforeSetSeconds, ')
          ..write('restAfterSetSeconds: $restAfterSetSeconds, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      workoutExerciseId,
      setNumber,
      weightKg,
      reps,
      loadType,
      rpe,
      rir,
      isWarmup,
      isFailure,
      estimatedOneRepMaxKg,
      restBeforeSetSeconds,
      restAfterSetSeconds,
      startedAt,
      completedAt,
      createdAt,
      updatedAt,
      notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSetRow &&
          other.id == this.id &&
          other.workoutExerciseId == this.workoutExerciseId &&
          other.setNumber == this.setNumber &&
          other.weightKg == this.weightKg &&
          other.reps == this.reps &&
          other.loadType == this.loadType &&
          other.rpe == this.rpe &&
          other.rir == this.rir &&
          other.isWarmup == this.isWarmup &&
          other.isFailure == this.isFailure &&
          other.estimatedOneRepMaxKg == this.estimatedOneRepMaxKg &&
          other.restBeforeSetSeconds == this.restBeforeSetSeconds &&
          other.restAfterSetSeconds == this.restAfterSetSeconds &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.notes == this.notes);
}

class WorkoutSetsCompanion extends UpdateCompanion<WorkoutSetRow> {
  final Value<String> id;
  final Value<String> workoutExerciseId;
  final Value<int> setNumber;
  final Value<double> weightKg;
  final Value<int> reps;
  final Value<WorkoutSetLoadType> loadType;
  final Value<double?> rpe;
  final Value<int?> rir;
  final Value<bool> isWarmup;
  final Value<bool> isFailure;
  final Value<double?> estimatedOneRepMaxKg;
  final Value<int?> restBeforeSetSeconds;
  final Value<int?> restAfterSetSeconds;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> notes;
  final Value<int> rowid;
  const WorkoutSetsCompanion({
    this.id = const Value.absent(),
    this.workoutExerciseId = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.reps = const Value.absent(),
    this.loadType = const Value.absent(),
    this.rpe = const Value.absent(),
    this.rir = const Value.absent(),
    this.isWarmup = const Value.absent(),
    this.isFailure = const Value.absent(),
    this.estimatedOneRepMaxKg = const Value.absent(),
    this.restBeforeSetSeconds = const Value.absent(),
    this.restAfterSetSeconds = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutSetsCompanion.insert({
    required String id,
    required String workoutExerciseId,
    required int setNumber,
    required double weightKg,
    required int reps,
    this.loadType = const Value.absent(),
    this.rpe = const Value.absent(),
    this.rir = const Value.absent(),
    this.isWarmup = const Value.absent(),
    this.isFailure = const Value.absent(),
    this.estimatedOneRepMaxKg = const Value.absent(),
    this.restBeforeSetSeconds = const Value.absent(),
    this.restAfterSetSeconds = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workoutExerciseId = Value(workoutExerciseId),
        setNumber = Value(setNumber),
        weightKg = Value(weightKg),
        reps = Value(reps),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<WorkoutSetRow> custom({
    Expression<String>? id,
    Expression<String>? workoutExerciseId,
    Expression<int>? setNumber,
    Expression<double>? weightKg,
    Expression<int>? reps,
    Expression<String>? loadType,
    Expression<double>? rpe,
    Expression<int>? rir,
    Expression<bool>? isWarmup,
    Expression<bool>? isFailure,
    Expression<double>? estimatedOneRepMaxKg,
    Expression<int>? restBeforeSetSeconds,
    Expression<int>? restAfterSetSeconds,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutExerciseId != null) 'workout_exercise_id': workoutExerciseId,
      if (setNumber != null) 'set_number': setNumber,
      if (weightKg != null) 'weight_kg': weightKg,
      if (reps != null) 'reps': reps,
      if (loadType != null) 'load_type': loadType,
      if (rpe != null) 'rpe': rpe,
      if (rir != null) 'rir': rir,
      if (isWarmup != null) 'is_warmup': isWarmup,
      if (isFailure != null) 'is_failure': isFailure,
      if (estimatedOneRepMaxKg != null)
        'estimated_one_rep_max_kg': estimatedOneRepMaxKg,
      if (restBeforeSetSeconds != null)
        'rest_before_set_seconds': restBeforeSetSeconds,
      if (restAfterSetSeconds != null)
        'rest_after_set_seconds': restAfterSetSeconds,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutSetsCompanion copyWith(
      {Value<String>? id,
      Value<String>? workoutExerciseId,
      Value<int>? setNumber,
      Value<double>? weightKg,
      Value<int>? reps,
      Value<WorkoutSetLoadType>? loadType,
      Value<double?>? rpe,
      Value<int?>? rir,
      Value<bool>? isWarmup,
      Value<bool>? isFailure,
      Value<double?>? estimatedOneRepMaxKg,
      Value<int?>? restBeforeSetSeconds,
      Value<int?>? restAfterSetSeconds,
      Value<DateTime?>? startedAt,
      Value<DateTime?>? completedAt,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String?>? notes,
      Value<int>? rowid}) {
    return WorkoutSetsCompanion(
      id: id ?? this.id,
      workoutExerciseId: workoutExerciseId ?? this.workoutExerciseId,
      setNumber: setNumber ?? this.setNumber,
      weightKg: weightKg ?? this.weightKg,
      reps: reps ?? this.reps,
      loadType: loadType ?? this.loadType,
      rpe: rpe ?? this.rpe,
      rir: rir ?? this.rir,
      isWarmup: isWarmup ?? this.isWarmup,
      isFailure: isFailure ?? this.isFailure,
      estimatedOneRepMaxKg: estimatedOneRepMaxKg ?? this.estimatedOneRepMaxKg,
      restBeforeSetSeconds: restBeforeSetSeconds ?? this.restBeforeSetSeconds,
      restAfterSetSeconds: restAfterSetSeconds ?? this.restAfterSetSeconds,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workoutExerciseId.present) {
      map['workout_exercise_id'] = Variable<String>(workoutExerciseId.value);
    }
    if (setNumber.present) {
      map['set_number'] = Variable<int>(setNumber.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (loadType.present) {
      map['load_type'] = Variable<String>(
          $WorkoutSetsTable.$converterloadType.toSql(loadType.value));
    }
    if (rpe.present) {
      map['rpe'] = Variable<double>(rpe.value);
    }
    if (rir.present) {
      map['rir'] = Variable<int>(rir.value);
    }
    if (isWarmup.present) {
      map['is_warmup'] = Variable<bool>(isWarmup.value);
    }
    if (isFailure.present) {
      map['is_failure'] = Variable<bool>(isFailure.value);
    }
    if (estimatedOneRepMaxKg.present) {
      map['estimated_one_rep_max_kg'] =
          Variable<double>(estimatedOneRepMaxKg.value);
    }
    if (restBeforeSetSeconds.present) {
      map['rest_before_set_seconds'] =
          Variable<int>(restBeforeSetSeconds.value);
    }
    if (restAfterSetSeconds.present) {
      map['rest_after_set_seconds'] = Variable<int>(restAfterSetSeconds.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSetsCompanion(')
          ..write('id: $id, ')
          ..write('workoutExerciseId: $workoutExerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('weightKg: $weightKg, ')
          ..write('reps: $reps, ')
          ..write('loadType: $loadType, ')
          ..write('rpe: $rpe, ')
          ..write('rir: $rir, ')
          ..write('isWarmup: $isWarmup, ')
          ..write('isFailure: $isFailure, ')
          ..write('estimatedOneRepMaxKg: $estimatedOneRepMaxKg, ')
          ..write('restBeforeSetSeconds: $restBeforeSetSeconds, ')
          ..write('restAfterSetSeconds: $restAfterSetSeconds, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RestTimerStatesTable extends RestTimerStates
    with TableInfo<$RestTimerStatesTable, RestTimerStateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RestTimerStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exerciseIdMeta =
      const VerificationMeta('exerciseId');
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
      'exercise_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _afterSetIdMeta =
      const VerificationMeta('afterSetId');
  @override
  late final GeneratedColumn<String> afterSetId = GeneratedColumn<String>(
      'after_set_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endsAtMeta = const VerificationMeta('endsAt');
  @override
  late final GeneratedColumn<DateTime> endsAt = GeneratedColumn<DateTime>(
      'ends_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _totalSecondsMeta =
      const VerificationMeta('totalSeconds');
  @override
  late final GeneratedColumn<int> totalSeconds = GeneratedColumn<int>(
      'total_seconds', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isRunningMeta =
      const VerificationMeta('isRunning');
  @override
  late final GeneratedColumn<bool> isRunning = GeneratedColumn<bool>(
      'is_running', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_running" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isPausedMeta =
      const VerificationMeta('isPaused');
  @override
  late final GeneratedColumn<bool> isPaused = GeneratedColumn<bool>(
      'is_paused', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_paused" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _pausedAtMeta =
      const VerificationMeta('pausedAt');
  @override
  late final GeneratedColumn<DateTime> pausedAt = GeneratedColumn<DateTime>(
      'paused_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _accumulatedPausedSecondsMeta =
      const VerificationMeta('accumulatedPausedSeconds');
  @override
  late final GeneratedColumn<int> accumulatedPausedSeconds =
      GeneratedColumn<int>('accumulated_paused_seconds', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _allowSilentNotificationMeta =
      const VerificationMeta('allowSilentNotification');
  @override
  late final GeneratedColumn<bool> allowSilentNotification =
      GeneratedColumn<bool>('allow_silent_notification', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("allow_silent_notification" IN (0, 1))'),
          defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        sessionId,
        exerciseId,
        afterSetId,
        startedAt,
        endsAt,
        totalSeconds,
        isRunning,
        isPaused,
        pausedAt,
        accumulatedPausedSeconds,
        allowSilentNotification
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rest_timer_states';
  @override
  VerificationContext validateIntegrity(Insertable<RestTimerStateRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id']!, _exerciseIdMeta));
    }
    if (data.containsKey('after_set_id')) {
      context.handle(
          _afterSetIdMeta,
          afterSetId.isAcceptableOrUnknown(
              data['after_set_id']!, _afterSetIdMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ends_at')) {
      context.handle(_endsAtMeta,
          endsAt.isAcceptableOrUnknown(data['ends_at']!, _endsAtMeta));
    } else if (isInserting) {
      context.missing(_endsAtMeta);
    }
    if (data.containsKey('total_seconds')) {
      context.handle(
          _totalSecondsMeta,
          totalSeconds.isAcceptableOrUnknown(
              data['total_seconds']!, _totalSecondsMeta));
    } else if (isInserting) {
      context.missing(_totalSecondsMeta);
    }
    if (data.containsKey('is_running')) {
      context.handle(_isRunningMeta,
          isRunning.isAcceptableOrUnknown(data['is_running']!, _isRunningMeta));
    }
    if (data.containsKey('is_paused')) {
      context.handle(_isPausedMeta,
          isPaused.isAcceptableOrUnknown(data['is_paused']!, _isPausedMeta));
    }
    if (data.containsKey('paused_at')) {
      context.handle(_pausedAtMeta,
          pausedAt.isAcceptableOrUnknown(data['paused_at']!, _pausedAtMeta));
    }
    if (data.containsKey('accumulated_paused_seconds')) {
      context.handle(
          _accumulatedPausedSecondsMeta,
          accumulatedPausedSeconds.isAcceptableOrUnknown(
              data['accumulated_paused_seconds']!,
              _accumulatedPausedSecondsMeta));
    }
    if (data.containsKey('allow_silent_notification')) {
      context.handle(
          _allowSilentNotificationMeta,
          allowSilentNotification.isAcceptableOrUnknown(
              data['allow_silent_notification']!,
              _allowSilentNotificationMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sessionId};
  @override
  RestTimerStateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RestTimerStateRow(
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id'])!,
      exerciseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_id']),
      afterSetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}after_set_id']),
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      endsAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}ends_at'])!,
      totalSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_seconds'])!,
      isRunning: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_running'])!,
      isPaused: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_paused'])!,
      pausedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}paused_at']),
      accumulatedPausedSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}accumulated_paused_seconds'])!,
      allowSilentNotification: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}allow_silent_notification'])!,
    );
  }

  @override
  $RestTimerStatesTable createAlias(String alias) {
    return $RestTimerStatesTable(attachedDatabase, alias);
  }
}

class RestTimerStateRow extends DataClass
    implements Insertable<RestTimerStateRow> {
  final String sessionId;
  final String? exerciseId;
  final String? afterSetId;
  final DateTime startedAt;
  final DateTime endsAt;
  final int totalSeconds;
  final bool isRunning;
  final bool isPaused;
  final DateTime? pausedAt;
  final int accumulatedPausedSeconds;
  final bool allowSilentNotification;
  const RestTimerStateRow(
      {required this.sessionId,
      this.exerciseId,
      this.afterSetId,
      required this.startedAt,
      required this.endsAt,
      required this.totalSeconds,
      required this.isRunning,
      required this.isPaused,
      this.pausedAt,
      required this.accumulatedPausedSeconds,
      required this.allowSilentNotification});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['session_id'] = Variable<String>(sessionId);
    if (!nullToAbsent || exerciseId != null) {
      map['exercise_id'] = Variable<String>(exerciseId);
    }
    if (!nullToAbsent || afterSetId != null) {
      map['after_set_id'] = Variable<String>(afterSetId);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    map['ends_at'] = Variable<DateTime>(endsAt);
    map['total_seconds'] = Variable<int>(totalSeconds);
    map['is_running'] = Variable<bool>(isRunning);
    map['is_paused'] = Variable<bool>(isPaused);
    if (!nullToAbsent || pausedAt != null) {
      map['paused_at'] = Variable<DateTime>(pausedAt);
    }
    map['accumulated_paused_seconds'] = Variable<int>(accumulatedPausedSeconds);
    map['allow_silent_notification'] = Variable<bool>(allowSilentNotification);
    return map;
  }

  RestTimerStatesCompanion toCompanion(bool nullToAbsent) {
    return RestTimerStatesCompanion(
      sessionId: Value(sessionId),
      exerciseId: exerciseId == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseId),
      afterSetId: afterSetId == null && nullToAbsent
          ? const Value.absent()
          : Value(afterSetId),
      startedAt: Value(startedAt),
      endsAt: Value(endsAt),
      totalSeconds: Value(totalSeconds),
      isRunning: Value(isRunning),
      isPaused: Value(isPaused),
      pausedAt: pausedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(pausedAt),
      accumulatedPausedSeconds: Value(accumulatedPausedSeconds),
      allowSilentNotification: Value(allowSilentNotification),
    );
  }

  factory RestTimerStateRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RestTimerStateRow(
      sessionId: serializer.fromJson<String>(json['sessionId']),
      exerciseId: serializer.fromJson<String?>(json['exerciseId']),
      afterSetId: serializer.fromJson<String?>(json['afterSetId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endsAt: serializer.fromJson<DateTime>(json['endsAt']),
      totalSeconds: serializer.fromJson<int>(json['totalSeconds']),
      isRunning: serializer.fromJson<bool>(json['isRunning']),
      isPaused: serializer.fromJson<bool>(json['isPaused']),
      pausedAt: serializer.fromJson<DateTime?>(json['pausedAt']),
      accumulatedPausedSeconds:
          serializer.fromJson<int>(json['accumulatedPausedSeconds']),
      allowSilentNotification:
          serializer.fromJson<bool>(json['allowSilentNotification']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sessionId': serializer.toJson<String>(sessionId),
      'exerciseId': serializer.toJson<String?>(exerciseId),
      'afterSetId': serializer.toJson<String?>(afterSetId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endsAt': serializer.toJson<DateTime>(endsAt),
      'totalSeconds': serializer.toJson<int>(totalSeconds),
      'isRunning': serializer.toJson<bool>(isRunning),
      'isPaused': serializer.toJson<bool>(isPaused),
      'pausedAt': serializer.toJson<DateTime?>(pausedAt),
      'accumulatedPausedSeconds':
          serializer.toJson<int>(accumulatedPausedSeconds),
      'allowSilentNotification':
          serializer.toJson<bool>(allowSilentNotification),
    };
  }

  RestTimerStateRow copyWith(
          {String? sessionId,
          Value<String?> exerciseId = const Value.absent(),
          Value<String?> afterSetId = const Value.absent(),
          DateTime? startedAt,
          DateTime? endsAt,
          int? totalSeconds,
          bool? isRunning,
          bool? isPaused,
          Value<DateTime?> pausedAt = const Value.absent(),
          int? accumulatedPausedSeconds,
          bool? allowSilentNotification}) =>
      RestTimerStateRow(
        sessionId: sessionId ?? this.sessionId,
        exerciseId: exerciseId.present ? exerciseId.value : this.exerciseId,
        afterSetId: afterSetId.present ? afterSetId.value : this.afterSetId,
        startedAt: startedAt ?? this.startedAt,
        endsAt: endsAt ?? this.endsAt,
        totalSeconds: totalSeconds ?? this.totalSeconds,
        isRunning: isRunning ?? this.isRunning,
        isPaused: isPaused ?? this.isPaused,
        pausedAt: pausedAt.present ? pausedAt.value : this.pausedAt,
        accumulatedPausedSeconds:
            accumulatedPausedSeconds ?? this.accumulatedPausedSeconds,
        allowSilentNotification:
            allowSilentNotification ?? this.allowSilentNotification,
      );
  RestTimerStateRow copyWithCompanion(RestTimerStatesCompanion data) {
    return RestTimerStateRow(
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      exerciseId:
          data.exerciseId.present ? data.exerciseId.value : this.exerciseId,
      afterSetId:
          data.afterSetId.present ? data.afterSetId.value : this.afterSetId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endsAt: data.endsAt.present ? data.endsAt.value : this.endsAt,
      totalSeconds: data.totalSeconds.present
          ? data.totalSeconds.value
          : this.totalSeconds,
      isRunning: data.isRunning.present ? data.isRunning.value : this.isRunning,
      isPaused: data.isPaused.present ? data.isPaused.value : this.isPaused,
      pausedAt: data.pausedAt.present ? data.pausedAt.value : this.pausedAt,
      accumulatedPausedSeconds: data.accumulatedPausedSeconds.present
          ? data.accumulatedPausedSeconds.value
          : this.accumulatedPausedSeconds,
      allowSilentNotification: data.allowSilentNotification.present
          ? data.allowSilentNotification.value
          : this.allowSilentNotification,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RestTimerStateRow(')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('afterSetId: $afterSetId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endsAt: $endsAt, ')
          ..write('totalSeconds: $totalSeconds, ')
          ..write('isRunning: $isRunning, ')
          ..write('isPaused: $isPaused, ')
          ..write('pausedAt: $pausedAt, ')
          ..write('accumulatedPausedSeconds: $accumulatedPausedSeconds, ')
          ..write('allowSilentNotification: $allowSilentNotification')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      sessionId,
      exerciseId,
      afterSetId,
      startedAt,
      endsAt,
      totalSeconds,
      isRunning,
      isPaused,
      pausedAt,
      accumulatedPausedSeconds,
      allowSilentNotification);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RestTimerStateRow &&
          other.sessionId == this.sessionId &&
          other.exerciseId == this.exerciseId &&
          other.afterSetId == this.afterSetId &&
          other.startedAt == this.startedAt &&
          other.endsAt == this.endsAt &&
          other.totalSeconds == this.totalSeconds &&
          other.isRunning == this.isRunning &&
          other.isPaused == this.isPaused &&
          other.pausedAt == this.pausedAt &&
          other.accumulatedPausedSeconds == this.accumulatedPausedSeconds &&
          other.allowSilentNotification == this.allowSilentNotification);
}

class RestTimerStatesCompanion extends UpdateCompanion<RestTimerStateRow> {
  final Value<String> sessionId;
  final Value<String?> exerciseId;
  final Value<String?> afterSetId;
  final Value<DateTime> startedAt;
  final Value<DateTime> endsAt;
  final Value<int> totalSeconds;
  final Value<bool> isRunning;
  final Value<bool> isPaused;
  final Value<DateTime?> pausedAt;
  final Value<int> accumulatedPausedSeconds;
  final Value<bool> allowSilentNotification;
  final Value<int> rowid;
  const RestTimerStatesCompanion({
    this.sessionId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.afterSetId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endsAt = const Value.absent(),
    this.totalSeconds = const Value.absent(),
    this.isRunning = const Value.absent(),
    this.isPaused = const Value.absent(),
    this.pausedAt = const Value.absent(),
    this.accumulatedPausedSeconds = const Value.absent(),
    this.allowSilentNotification = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RestTimerStatesCompanion.insert({
    required String sessionId,
    this.exerciseId = const Value.absent(),
    this.afterSetId = const Value.absent(),
    required DateTime startedAt,
    required DateTime endsAt,
    required int totalSeconds,
    this.isRunning = const Value.absent(),
    this.isPaused = const Value.absent(),
    this.pausedAt = const Value.absent(),
    this.accumulatedPausedSeconds = const Value.absent(),
    this.allowSilentNotification = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : sessionId = Value(sessionId),
        startedAt = Value(startedAt),
        endsAt = Value(endsAt),
        totalSeconds = Value(totalSeconds);
  static Insertable<RestTimerStateRow> custom({
    Expression<String>? sessionId,
    Expression<String>? exerciseId,
    Expression<String>? afterSetId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endsAt,
    Expression<int>? totalSeconds,
    Expression<bool>? isRunning,
    Expression<bool>? isPaused,
    Expression<DateTime>? pausedAt,
    Expression<int>? accumulatedPausedSeconds,
    Expression<bool>? allowSilentNotification,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sessionId != null) 'session_id': sessionId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (afterSetId != null) 'after_set_id': afterSetId,
      if (startedAt != null) 'started_at': startedAt,
      if (endsAt != null) 'ends_at': endsAt,
      if (totalSeconds != null) 'total_seconds': totalSeconds,
      if (isRunning != null) 'is_running': isRunning,
      if (isPaused != null) 'is_paused': isPaused,
      if (pausedAt != null) 'paused_at': pausedAt,
      if (accumulatedPausedSeconds != null)
        'accumulated_paused_seconds': accumulatedPausedSeconds,
      if (allowSilentNotification != null)
        'allow_silent_notification': allowSilentNotification,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RestTimerStatesCompanion copyWith(
      {Value<String>? sessionId,
      Value<String?>? exerciseId,
      Value<String?>? afterSetId,
      Value<DateTime>? startedAt,
      Value<DateTime>? endsAt,
      Value<int>? totalSeconds,
      Value<bool>? isRunning,
      Value<bool>? isPaused,
      Value<DateTime?>? pausedAt,
      Value<int>? accumulatedPausedSeconds,
      Value<bool>? allowSilentNotification,
      Value<int>? rowid}) {
    return RestTimerStatesCompanion(
      sessionId: sessionId ?? this.sessionId,
      exerciseId: exerciseId ?? this.exerciseId,
      afterSetId: afterSetId ?? this.afterSetId,
      startedAt: startedAt ?? this.startedAt,
      endsAt: endsAt ?? this.endsAt,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      isRunning: isRunning ?? this.isRunning,
      isPaused: isPaused ?? this.isPaused,
      pausedAt: pausedAt ?? this.pausedAt,
      accumulatedPausedSeconds:
          accumulatedPausedSeconds ?? this.accumulatedPausedSeconds,
      allowSilentNotification:
          allowSilentNotification ?? this.allowSilentNotification,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (afterSetId.present) {
      map['after_set_id'] = Variable<String>(afterSetId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endsAt.present) {
      map['ends_at'] = Variable<DateTime>(endsAt.value);
    }
    if (totalSeconds.present) {
      map['total_seconds'] = Variable<int>(totalSeconds.value);
    }
    if (isRunning.present) {
      map['is_running'] = Variable<bool>(isRunning.value);
    }
    if (isPaused.present) {
      map['is_paused'] = Variable<bool>(isPaused.value);
    }
    if (pausedAt.present) {
      map['paused_at'] = Variable<DateTime>(pausedAt.value);
    }
    if (accumulatedPausedSeconds.present) {
      map['accumulated_paused_seconds'] =
          Variable<int>(accumulatedPausedSeconds.value);
    }
    if (allowSilentNotification.present) {
      map['allow_silent_notification'] =
          Variable<bool>(allowSilentNotification.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RestTimerStatesCompanion(')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('afterSetId: $afterSetId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endsAt: $endsAt, ')
          ..write('totalSeconds: $totalSeconds, ')
          ..write('isRunning: $isRunning, ')
          ..write('isPaused: $isPaused, ')
          ..write('pausedAt: $pausedAt, ')
          ..write('accumulatedPausedSeconds: $accumulatedPausedSeconds, ')
          ..write('allowSilentNotification: $allowSilentNotification, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseMuscleTargetsTable extends ExerciseMuscleTargets
    with TableInfo<$ExerciseMuscleTargetsTable, ExerciseMuscleTargetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseMuscleTargetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exerciseIdMeta =
      const VerificationMeta('exerciseId');
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
      'exercise_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<MuscleGroup, String> muscleGroup =
      GeneratedColumn<String>('muscle_group', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<MuscleGroup>(
              $ExerciseMuscleTargetsTable.$convertermuscleGroup);
  @override
  late final GeneratedColumnWithTypeConverter<MuscleRole, String> role =
      GeneratedColumn<String>('role', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<MuscleRole>(
              $ExerciseMuscleTargetsTable.$converterrole);
  static const VerificationMeta _contributionMeta =
      const VerificationMeta('contribution');
  @override
  late final GeneratedColumn<double> contribution = GeneratedColumn<double>(
      'contribution', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, exerciseId, muscleGroup, role, contribution];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_muscle_targets';
  @override
  VerificationContext validateIntegrity(
      Insertable<ExerciseMuscleTargetRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id']!, _exerciseIdMeta));
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('contribution')) {
      context.handle(
          _contributionMeta,
          contribution.isAcceptableOrUnknown(
              data['contribution']!, _contributionMeta));
    } else if (isInserting) {
      context.missing(_contributionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseMuscleTargetRow map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseMuscleTargetRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      exerciseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_id'])!,
      muscleGroup: $ExerciseMuscleTargetsTable.$convertermuscleGroup.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}muscle_group'])!),
      role: $ExerciseMuscleTargetsTable.$converterrole.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!),
      contribution: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}contribution'])!,
    );
  }

  @override
  $ExerciseMuscleTargetsTable createAlias(String alias) {
    return $ExerciseMuscleTargetsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MuscleGroup, String, String> $convertermuscleGroup =
      const EnumNameConverter<MuscleGroup>(MuscleGroup.values);
  static JsonTypeConverter2<MuscleRole, String, String> $converterrole =
      const EnumNameConverter<MuscleRole>(MuscleRole.values);
}

class ExerciseMuscleTargetRow extends DataClass
    implements Insertable<ExerciseMuscleTargetRow> {
  final String id;
  final String exerciseId;
  final MuscleGroup muscleGroup;
  final MuscleRole role;
  final double contribution;
  const ExerciseMuscleTargetRow(
      {required this.id,
      required this.exerciseId,
      required this.muscleGroup,
      required this.role,
      required this.contribution});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['exercise_id'] = Variable<String>(exerciseId);
    {
      map['muscle_group'] = Variable<String>(
          $ExerciseMuscleTargetsTable.$convertermuscleGroup.toSql(muscleGroup));
    }
    {
      map['role'] = Variable<String>(
          $ExerciseMuscleTargetsTable.$converterrole.toSql(role));
    }
    map['contribution'] = Variable<double>(contribution);
    return map;
  }

  ExerciseMuscleTargetsCompanion toCompanion(bool nullToAbsent) {
    return ExerciseMuscleTargetsCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      muscleGroup: Value(muscleGroup),
      role: Value(role),
      contribution: Value(contribution),
    );
  }

  factory ExerciseMuscleTargetRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseMuscleTargetRow(
      id: serializer.fromJson<String>(json['id']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      muscleGroup: $ExerciseMuscleTargetsTable.$convertermuscleGroup
          .fromJson(serializer.fromJson<String>(json['muscleGroup'])),
      role: $ExerciseMuscleTargetsTable.$converterrole
          .fromJson(serializer.fromJson<String>(json['role'])),
      contribution: serializer.fromJson<double>(json['contribution']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'muscleGroup': serializer.toJson<String>($ExerciseMuscleTargetsTable
          .$convertermuscleGroup
          .toJson(muscleGroup)),
      'role': serializer.toJson<String>(
          $ExerciseMuscleTargetsTable.$converterrole.toJson(role)),
      'contribution': serializer.toJson<double>(contribution),
    };
  }

  ExerciseMuscleTargetRow copyWith(
          {String? id,
          String? exerciseId,
          MuscleGroup? muscleGroup,
          MuscleRole? role,
          double? contribution}) =>
      ExerciseMuscleTargetRow(
        id: id ?? this.id,
        exerciseId: exerciseId ?? this.exerciseId,
        muscleGroup: muscleGroup ?? this.muscleGroup,
        role: role ?? this.role,
        contribution: contribution ?? this.contribution,
      );
  ExerciseMuscleTargetRow copyWithCompanion(
      ExerciseMuscleTargetsCompanion data) {
    return ExerciseMuscleTargetRow(
      id: data.id.present ? data.id.value : this.id,
      exerciseId:
          data.exerciseId.present ? data.exerciseId.value : this.exerciseId,
      muscleGroup:
          data.muscleGroup.present ? data.muscleGroup.value : this.muscleGroup,
      role: data.role.present ? data.role.value : this.role,
      contribution: data.contribution.present
          ? data.contribution.value
          : this.contribution,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseMuscleTargetRow(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('role: $role, ')
          ..write('contribution: $contribution')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, exerciseId, muscleGroup, role, contribution);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseMuscleTargetRow &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.muscleGroup == this.muscleGroup &&
          other.role == this.role &&
          other.contribution == this.contribution);
}

class ExerciseMuscleTargetsCompanion
    extends UpdateCompanion<ExerciseMuscleTargetRow> {
  final Value<String> id;
  final Value<String> exerciseId;
  final Value<MuscleGroup> muscleGroup;
  final Value<MuscleRole> role;
  final Value<double> contribution;
  final Value<int> rowid;
  const ExerciseMuscleTargetsCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.muscleGroup = const Value.absent(),
    this.role = const Value.absent(),
    this.contribution = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseMuscleTargetsCompanion.insert({
    required String id,
    required String exerciseId,
    required MuscleGroup muscleGroup,
    required MuscleRole role,
    required double contribution,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        exerciseId = Value(exerciseId),
        muscleGroup = Value(muscleGroup),
        role = Value(role),
        contribution = Value(contribution);
  static Insertable<ExerciseMuscleTargetRow> custom({
    Expression<String>? id,
    Expression<String>? exerciseId,
    Expression<String>? muscleGroup,
    Expression<String>? role,
    Expression<double>? contribution,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (muscleGroup != null) 'muscle_group': muscleGroup,
      if (role != null) 'role': role,
      if (contribution != null) 'contribution': contribution,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseMuscleTargetsCompanion copyWith(
      {Value<String>? id,
      Value<String>? exerciseId,
      Value<MuscleGroup>? muscleGroup,
      Value<MuscleRole>? role,
      Value<double>? contribution,
      Value<int>? rowid}) {
    return ExerciseMuscleTargetsCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      role: role ?? this.role,
      contribution: contribution ?? this.contribution,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (muscleGroup.present) {
      map['muscle_group'] = Variable<String>($ExerciseMuscleTargetsTable
          .$convertermuscleGroup
          .toSql(muscleGroup.value));
    }
    if (role.present) {
      map['role'] = Variable<String>(
          $ExerciseMuscleTargetsTable.$converterrole.toSql(role.value));
    }
    if (contribution.present) {
      map['contribution'] = Variable<double>(contribution.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseMuscleTargetsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('role: $role, ')
          ..write('contribution: $contribution, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutMuscleImpactsTable extends WorkoutMuscleImpacts
    with TableInfo<$WorkoutMuscleImpactsTable, WorkoutMuscleImpactRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutMuscleImpactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<MuscleGroup, String> muscleGroup =
      GeneratedColumn<String>('muscle_group', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<MuscleGroup>(
              $WorkoutMuscleImpactsTable.$convertermuscleGroup);
  static const VerificationMeta _rawScoreMeta =
      const VerificationMeta('rawScore');
  @override
  late final GeneratedColumn<double> rawScore = GeneratedColumn<double>(
      'raw_score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _normalizedScoreMeta =
      const VerificationMeta('normalizedScore');
  @override
  late final GeneratedColumn<double> normalizedScore = GeneratedColumn<double>(
      'normalized_score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _workingSetsMeta =
      const VerificationMeta('workingSets');
  @override
  late final GeneratedColumn<int> workingSets = GeneratedColumn<int>(
      'working_sets', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _volumeMeta = const VerificationMeta('volume');
  @override
  late final GeneratedColumn<double> volume = GeneratedColumn<double>(
      'volume', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<MuscleRole, String>
      strongestRole = GeneratedColumn<String>(
              'strongest_role', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<MuscleRole>(
              $WorkoutMuscleImpactsTable.$converterstrongestRole);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sessionId,
        muscleGroup,
        rawScore,
        normalizedScore,
        workingSets,
        volume,
        strongestRole
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_muscle_impacts';
  @override
  VerificationContext validateIntegrity(
      Insertable<WorkoutMuscleImpactRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('raw_score')) {
      context.handle(_rawScoreMeta,
          rawScore.isAcceptableOrUnknown(data['raw_score']!, _rawScoreMeta));
    } else if (isInserting) {
      context.missing(_rawScoreMeta);
    }
    if (data.containsKey('normalized_score')) {
      context.handle(
          _normalizedScoreMeta,
          normalizedScore.isAcceptableOrUnknown(
              data['normalized_score']!, _normalizedScoreMeta));
    } else if (isInserting) {
      context.missing(_normalizedScoreMeta);
    }
    if (data.containsKey('working_sets')) {
      context.handle(
          _workingSetsMeta,
          workingSets.isAcceptableOrUnknown(
              data['working_sets']!, _workingSetsMeta));
    } else if (isInserting) {
      context.missing(_workingSetsMeta);
    }
    if (data.containsKey('volume')) {
      context.handle(_volumeMeta,
          volume.isAcceptableOrUnknown(data['volume']!, _volumeMeta));
    } else if (isInserting) {
      context.missing(_volumeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutMuscleImpactRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutMuscleImpactRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id'])!,
      muscleGroup: $WorkoutMuscleImpactsTable.$convertermuscleGroup.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}muscle_group'])!),
      rawScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}raw_score'])!,
      normalizedScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}normalized_score'])!,
      workingSets: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}working_sets'])!,
      volume: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}volume'])!,
      strongestRole: $WorkoutMuscleImpactsTable.$converterstrongestRole.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}strongest_role'])!),
    );
  }

  @override
  $WorkoutMuscleImpactsTable createAlias(String alias) {
    return $WorkoutMuscleImpactsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MuscleGroup, String, String> $convertermuscleGroup =
      const EnumNameConverter<MuscleGroup>(MuscleGroup.values);
  static JsonTypeConverter2<MuscleRole, String, String>
      $converterstrongestRole =
      const EnumNameConverter<MuscleRole>(MuscleRole.values);
}

class WorkoutMuscleImpactRow extends DataClass
    implements Insertable<WorkoutMuscleImpactRow> {
  final String id;
  final String sessionId;
  final MuscleGroup muscleGroup;
  final double rawScore;
  final double normalizedScore;
  final int workingSets;
  final double volume;
  final MuscleRole strongestRole;
  const WorkoutMuscleImpactRow(
      {required this.id,
      required this.sessionId,
      required this.muscleGroup,
      required this.rawScore,
      required this.normalizedScore,
      required this.workingSets,
      required this.volume,
      required this.strongestRole});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    {
      map['muscle_group'] = Variable<String>(
          $WorkoutMuscleImpactsTable.$convertermuscleGroup.toSql(muscleGroup));
    }
    map['raw_score'] = Variable<double>(rawScore);
    map['normalized_score'] = Variable<double>(normalizedScore);
    map['working_sets'] = Variable<int>(workingSets);
    map['volume'] = Variable<double>(volume);
    {
      map['strongest_role'] = Variable<String>($WorkoutMuscleImpactsTable
          .$converterstrongestRole
          .toSql(strongestRole));
    }
    return map;
  }

  WorkoutMuscleImpactsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutMuscleImpactsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      muscleGroup: Value(muscleGroup),
      rawScore: Value(rawScore),
      normalizedScore: Value(normalizedScore),
      workingSets: Value(workingSets),
      volume: Value(volume),
      strongestRole: Value(strongestRole),
    );
  }

  factory WorkoutMuscleImpactRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutMuscleImpactRow(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      muscleGroup: $WorkoutMuscleImpactsTable.$convertermuscleGroup
          .fromJson(serializer.fromJson<String>(json['muscleGroup'])),
      rawScore: serializer.fromJson<double>(json['rawScore']),
      normalizedScore: serializer.fromJson<double>(json['normalizedScore']),
      workingSets: serializer.fromJson<int>(json['workingSets']),
      volume: serializer.fromJson<double>(json['volume']),
      strongestRole: $WorkoutMuscleImpactsTable.$converterstrongestRole
          .fromJson(serializer.fromJson<String>(json['strongestRole'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'muscleGroup': serializer.toJson<String>(
          $WorkoutMuscleImpactsTable.$convertermuscleGroup.toJson(muscleGroup)),
      'rawScore': serializer.toJson<double>(rawScore),
      'normalizedScore': serializer.toJson<double>(normalizedScore),
      'workingSets': serializer.toJson<int>(workingSets),
      'volume': serializer.toJson<double>(volume),
      'strongestRole': serializer.toJson<String>($WorkoutMuscleImpactsTable
          .$converterstrongestRole
          .toJson(strongestRole)),
    };
  }

  WorkoutMuscleImpactRow copyWith(
          {String? id,
          String? sessionId,
          MuscleGroup? muscleGroup,
          double? rawScore,
          double? normalizedScore,
          int? workingSets,
          double? volume,
          MuscleRole? strongestRole}) =>
      WorkoutMuscleImpactRow(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        muscleGroup: muscleGroup ?? this.muscleGroup,
        rawScore: rawScore ?? this.rawScore,
        normalizedScore: normalizedScore ?? this.normalizedScore,
        workingSets: workingSets ?? this.workingSets,
        volume: volume ?? this.volume,
        strongestRole: strongestRole ?? this.strongestRole,
      );
  WorkoutMuscleImpactRow copyWithCompanion(WorkoutMuscleImpactsCompanion data) {
    return WorkoutMuscleImpactRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      muscleGroup:
          data.muscleGroup.present ? data.muscleGroup.value : this.muscleGroup,
      rawScore: data.rawScore.present ? data.rawScore.value : this.rawScore,
      normalizedScore: data.normalizedScore.present
          ? data.normalizedScore.value
          : this.normalizedScore,
      workingSets:
          data.workingSets.present ? data.workingSets.value : this.workingSets,
      volume: data.volume.present ? data.volume.value : this.volume,
      strongestRole: data.strongestRole.present
          ? data.strongestRole.value
          : this.strongestRole,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutMuscleImpactRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('rawScore: $rawScore, ')
          ..write('normalizedScore: $normalizedScore, ')
          ..write('workingSets: $workingSets, ')
          ..write('volume: $volume, ')
          ..write('strongestRole: $strongestRole')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, muscleGroup, rawScore,
      normalizedScore, workingSets, volume, strongestRole);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutMuscleImpactRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.muscleGroup == this.muscleGroup &&
          other.rawScore == this.rawScore &&
          other.normalizedScore == this.normalizedScore &&
          other.workingSets == this.workingSets &&
          other.volume == this.volume &&
          other.strongestRole == this.strongestRole);
}

class WorkoutMuscleImpactsCompanion
    extends UpdateCompanion<WorkoutMuscleImpactRow> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<MuscleGroup> muscleGroup;
  final Value<double> rawScore;
  final Value<double> normalizedScore;
  final Value<int> workingSets;
  final Value<double> volume;
  final Value<MuscleRole> strongestRole;
  final Value<int> rowid;
  const WorkoutMuscleImpactsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.muscleGroup = const Value.absent(),
    this.rawScore = const Value.absent(),
    this.normalizedScore = const Value.absent(),
    this.workingSets = const Value.absent(),
    this.volume = const Value.absent(),
    this.strongestRole = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutMuscleImpactsCompanion.insert({
    required String id,
    required String sessionId,
    required MuscleGroup muscleGroup,
    required double rawScore,
    required double normalizedScore,
    required int workingSets,
    required double volume,
    required MuscleRole strongestRole,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sessionId = Value(sessionId),
        muscleGroup = Value(muscleGroup),
        rawScore = Value(rawScore),
        normalizedScore = Value(normalizedScore),
        workingSets = Value(workingSets),
        volume = Value(volume),
        strongestRole = Value(strongestRole);
  static Insertable<WorkoutMuscleImpactRow> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? muscleGroup,
    Expression<double>? rawScore,
    Expression<double>? normalizedScore,
    Expression<int>? workingSets,
    Expression<double>? volume,
    Expression<String>? strongestRole,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (muscleGroup != null) 'muscle_group': muscleGroup,
      if (rawScore != null) 'raw_score': rawScore,
      if (normalizedScore != null) 'normalized_score': normalizedScore,
      if (workingSets != null) 'working_sets': workingSets,
      if (volume != null) 'volume': volume,
      if (strongestRole != null) 'strongest_role': strongestRole,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutMuscleImpactsCompanion copyWith(
      {Value<String>? id,
      Value<String>? sessionId,
      Value<MuscleGroup>? muscleGroup,
      Value<double>? rawScore,
      Value<double>? normalizedScore,
      Value<int>? workingSets,
      Value<double>? volume,
      Value<MuscleRole>? strongestRole,
      Value<int>? rowid}) {
    return WorkoutMuscleImpactsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      rawScore: rawScore ?? this.rawScore,
      normalizedScore: normalizedScore ?? this.normalizedScore,
      workingSets: workingSets ?? this.workingSets,
      volume: volume ?? this.volume,
      strongestRole: strongestRole ?? this.strongestRole,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (muscleGroup.present) {
      map['muscle_group'] = Variable<String>($WorkoutMuscleImpactsTable
          .$convertermuscleGroup
          .toSql(muscleGroup.value));
    }
    if (rawScore.present) {
      map['raw_score'] = Variable<double>(rawScore.value);
    }
    if (normalizedScore.present) {
      map['normalized_score'] = Variable<double>(normalizedScore.value);
    }
    if (workingSets.present) {
      map['working_sets'] = Variable<int>(workingSets.value);
    }
    if (volume.present) {
      map['volume'] = Variable<double>(volume.value);
    }
    if (strongestRole.present) {
      map['strongest_role'] = Variable<String>($WorkoutMuscleImpactsTable
          .$converterstrongestRole
          .toSql(strongestRole.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutMuscleImpactsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('rawScore: $rawScore, ')
          ..write('normalizedScore: $normalizedScore, ')
          ..write('workingSets: $workingSets, ')
          ..write('volume: $volume, ')
          ..write('strongestRole: $strongestRole, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutRegionImpactsTable extends WorkoutRegionImpacts
    with TableInfo<$WorkoutRegionImpactsTable, WorkoutRegionImpactRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutRegionImpactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<MuscleRegion, String> region =
      GeneratedColumn<String>('region', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<MuscleRegion>(
              $WorkoutRegionImpactsTable.$converterregion);
  static const VerificationMeta _rawScoreMeta =
      const VerificationMeta('rawScore');
  @override
  late final GeneratedColumn<double> rawScore = GeneratedColumn<double>(
      'raw_score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _normalizedScoreMeta =
      const VerificationMeta('normalizedScore');
  @override
  late final GeneratedColumn<double> normalizedScore = GeneratedColumn<double>(
      'normalized_score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sessionId, region, rawScore, normalizedScore];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_region_impacts';
  @override
  VerificationContext validateIntegrity(
      Insertable<WorkoutRegionImpactRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('raw_score')) {
      context.handle(_rawScoreMeta,
          rawScore.isAcceptableOrUnknown(data['raw_score']!, _rawScoreMeta));
    } else if (isInserting) {
      context.missing(_rawScoreMeta);
    }
    if (data.containsKey('normalized_score')) {
      context.handle(
          _normalizedScoreMeta,
          normalizedScore.isAcceptableOrUnknown(
              data['normalized_score']!, _normalizedScoreMeta));
    } else if (isInserting) {
      context.missing(_normalizedScoreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutRegionImpactRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutRegionImpactRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id'])!,
      region: $WorkoutRegionImpactsTable.$converterregion.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}region'])!),
      rawScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}raw_score'])!,
      normalizedScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}normalized_score'])!,
    );
  }

  @override
  $WorkoutRegionImpactsTable createAlias(String alias) {
    return $WorkoutRegionImpactsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MuscleRegion, String, String> $converterregion =
      const EnumNameConverter<MuscleRegion>(MuscleRegion.values);
}

class WorkoutRegionImpactRow extends DataClass
    implements Insertable<WorkoutRegionImpactRow> {
  final String id;
  final String sessionId;
  final MuscleRegion region;
  final double rawScore;
  final double normalizedScore;
  const WorkoutRegionImpactRow(
      {required this.id,
      required this.sessionId,
      required this.region,
      required this.rawScore,
      required this.normalizedScore});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    {
      map['region'] = Variable<String>(
          $WorkoutRegionImpactsTable.$converterregion.toSql(region));
    }
    map['raw_score'] = Variable<double>(rawScore);
    map['normalized_score'] = Variable<double>(normalizedScore);
    return map;
  }

  WorkoutRegionImpactsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutRegionImpactsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      region: Value(region),
      rawScore: Value(rawScore),
      normalizedScore: Value(normalizedScore),
    );
  }

  factory WorkoutRegionImpactRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutRegionImpactRow(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      region: $WorkoutRegionImpactsTable.$converterregion
          .fromJson(serializer.fromJson<String>(json['region'])),
      rawScore: serializer.fromJson<double>(json['rawScore']),
      normalizedScore: serializer.fromJson<double>(json['normalizedScore']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'region': serializer.toJson<String>(
          $WorkoutRegionImpactsTable.$converterregion.toJson(region)),
      'rawScore': serializer.toJson<double>(rawScore),
      'normalizedScore': serializer.toJson<double>(normalizedScore),
    };
  }

  WorkoutRegionImpactRow copyWith(
          {String? id,
          String? sessionId,
          MuscleRegion? region,
          double? rawScore,
          double? normalizedScore}) =>
      WorkoutRegionImpactRow(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        region: region ?? this.region,
        rawScore: rawScore ?? this.rawScore,
        normalizedScore: normalizedScore ?? this.normalizedScore,
      );
  WorkoutRegionImpactRow copyWithCompanion(WorkoutRegionImpactsCompanion data) {
    return WorkoutRegionImpactRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      region: data.region.present ? data.region.value : this.region,
      rawScore: data.rawScore.present ? data.rawScore.value : this.rawScore,
      normalizedScore: data.normalizedScore.present
          ? data.normalizedScore.value
          : this.normalizedScore,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutRegionImpactRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('region: $region, ')
          ..write('rawScore: $rawScore, ')
          ..write('normalizedScore: $normalizedScore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sessionId, region, rawScore, normalizedScore);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutRegionImpactRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.region == this.region &&
          other.rawScore == this.rawScore &&
          other.normalizedScore == this.normalizedScore);
}

class WorkoutRegionImpactsCompanion
    extends UpdateCompanion<WorkoutRegionImpactRow> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<MuscleRegion> region;
  final Value<double> rawScore;
  final Value<double> normalizedScore;
  final Value<int> rowid;
  const WorkoutRegionImpactsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.region = const Value.absent(),
    this.rawScore = const Value.absent(),
    this.normalizedScore = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutRegionImpactsCompanion.insert({
    required String id,
    required String sessionId,
    required MuscleRegion region,
    required double rawScore,
    required double normalizedScore,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sessionId = Value(sessionId),
        region = Value(region),
        rawScore = Value(rawScore),
        normalizedScore = Value(normalizedScore);
  static Insertable<WorkoutRegionImpactRow> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? region,
    Expression<double>? rawScore,
    Expression<double>? normalizedScore,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (region != null) 'region': region,
      if (rawScore != null) 'raw_score': rawScore,
      if (normalizedScore != null) 'normalized_score': normalizedScore,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutRegionImpactsCompanion copyWith(
      {Value<String>? id,
      Value<String>? sessionId,
      Value<MuscleRegion>? region,
      Value<double>? rawScore,
      Value<double>? normalizedScore,
      Value<int>? rowid}) {
    return WorkoutRegionImpactsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      region: region ?? this.region,
      rawScore: rawScore ?? this.rawScore,
      normalizedScore: normalizedScore ?? this.normalizedScore,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(
          $WorkoutRegionImpactsTable.$converterregion.toSql(region.value));
    }
    if (rawScore.present) {
      map['raw_score'] = Variable<double>(rawScore.value);
    }
    if (normalizedScore.present) {
      map['normalized_score'] = Variable<double>(normalizedScore.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutRegionImpactsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('region: $region, ')
          ..write('rawScore: $rawScore, ')
          ..write('normalizedScore: $normalizedScore, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $WorkoutSessionsTable workoutSessions =
      $WorkoutSessionsTable(this);
  late final $WorkoutExercisesTable workoutExercises =
      $WorkoutExercisesTable(this);
  late final $WorkoutSetsTable workoutSets = $WorkoutSetsTable(this);
  late final $RestTimerStatesTable restTimerStates =
      $RestTimerStatesTable(this);
  late final $ExerciseMuscleTargetsTable exerciseMuscleTargets =
      $ExerciseMuscleTargetsTable(this);
  late final $WorkoutMuscleImpactsTable workoutMuscleImpacts =
      $WorkoutMuscleImpactsTable(this);
  late final $WorkoutRegionImpactsTable workoutRegionImpacts =
      $WorkoutRegionImpactsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        userProfiles,
        exercises,
        workoutSessions,
        workoutExercises,
        workoutSets,
        restTimerStates,
        exerciseMuscleTargets,
        workoutMuscleImpacts,
        workoutRegionImpacts
      ];
}

typedef $$UserProfilesTableCreateCompanionBuilder = UserProfilesCompanion
    Function({
  required String id,
  required String name,
  Value<int?> age,
  Value<String?> sex,
  Value<double?> heightCm,
  Value<double?> bodyWeightKg,
  required TrainingExperience trainingExperience,
  required TrainingGoal primaryGoal,
  required double preferredWeightIncrementKg,
  Value<bool> restTimerEnabled,
  Value<RecommendationStyle?> recommendationStyle,
  Value<int?> autoEndTimeoutMinutes,
  Value<bool?> restNotificationsEnabled,
  Value<bool?> soundEnabled,
  Value<bool?> vibrationEnabled,
  Value<int?> defaultAddRestSeconds,
  Value<bool?> showRpeRir,
  Value<double?> dumbbellIncrementKg,
  Value<double?> barbellIncrementKg,
  Value<double?> machineIncrementKg,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$UserProfilesTableUpdateCompanionBuilder = UserProfilesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<int?> age,
  Value<String?> sex,
  Value<double?> heightCm,
  Value<double?> bodyWeightKg,
  Value<TrainingExperience> trainingExperience,
  Value<TrainingGoal> primaryGoal,
  Value<double> preferredWeightIncrementKg,
  Value<bool> restTimerEnabled,
  Value<RecommendationStyle?> recommendationStyle,
  Value<int?> autoEndTimeoutMinutes,
  Value<bool?> restNotificationsEnabled,
  Value<bool?> soundEnabled,
  Value<bool?> vibrationEnabled,
  Value<int?> defaultAddRestSeconds,
  Value<bool?> showRpeRir,
  Value<double?> dumbbellIncrementKg,
  Value<double?> barbellIncrementKg,
  Value<double?> machineIncrementKg,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sex => $composableBuilder(
      column: $table.sex, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get heightCm => $composableBuilder(
      column: $table.heightCm, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get bodyWeightKg => $composableBuilder(
      column: $table.bodyWeightKg, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TrainingExperience, TrainingExperience, String>
      get trainingExperience => $composableBuilder(
          column: $table.trainingExperience,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<TrainingGoal, TrainingGoal, String>
      get primaryGoal => $composableBuilder(
          column: $table.primaryGoal,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get preferredWeightIncrementKg => $composableBuilder(
      column: $table.preferredWeightIncrementKg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get restTimerEnabled => $composableBuilder(
      column: $table.restTimerEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<RecommendationStyle?, RecommendationStyle,
          String>
      get recommendationStyle => $composableBuilder(
          column: $table.recommendationStyle,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get autoEndTimeoutMinutes => $composableBuilder(
      column: $table.autoEndTimeoutMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get restNotificationsEnabled => $composableBuilder(
      column: $table.restNotificationsEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get soundEnabled => $composableBuilder(
      column: $table.soundEnabled, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get vibrationEnabled => $composableBuilder(
      column: $table.vibrationEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get defaultAddRestSeconds => $composableBuilder(
      column: $table.defaultAddRestSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showRpeRir => $composableBuilder(
      column: $table.showRpeRir, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get dumbbellIncrementKg => $composableBuilder(
      column: $table.dumbbellIncrementKg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get barbellIncrementKg => $composableBuilder(
      column: $table.barbellIncrementKg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get machineIncrementKg => $composableBuilder(
      column: $table.machineIncrementKg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sex => $composableBuilder(
      column: $table.sex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get heightCm => $composableBuilder(
      column: $table.heightCm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get bodyWeightKg => $composableBuilder(
      column: $table.bodyWeightKg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get trainingExperience => $composableBuilder(
      column: $table.trainingExperience,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get primaryGoal => $composableBuilder(
      column: $table.primaryGoal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get preferredWeightIncrementKg => $composableBuilder(
      column: $table.preferredWeightIncrementKg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get restTimerEnabled => $composableBuilder(
      column: $table.restTimerEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recommendationStyle => $composableBuilder(
      column: $table.recommendationStyle,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get autoEndTimeoutMinutes => $composableBuilder(
      column: $table.autoEndTimeoutMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get restNotificationsEnabled => $composableBuilder(
      column: $table.restNotificationsEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get soundEnabled => $composableBuilder(
      column: $table.soundEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get vibrationEnabled => $composableBuilder(
      column: $table.vibrationEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get defaultAddRestSeconds => $composableBuilder(
      column: $table.defaultAddRestSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showRpeRir => $composableBuilder(
      column: $table.showRpeRir, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get dumbbellIncrementKg => $composableBuilder(
      column: $table.dumbbellIncrementKg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get barbellIncrementKg => $composableBuilder(
      column: $table.barbellIncrementKg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get machineIncrementKg => $composableBuilder(
      column: $table.machineIncrementKg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get bodyWeightKg => $composableBuilder(
      column: $table.bodyWeightKg, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TrainingExperience, String>
      get trainingExperience => $composableBuilder(
          column: $table.trainingExperience, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TrainingGoal, String> get primaryGoal =>
      $composableBuilder(
          column: $table.primaryGoal, builder: (column) => column);

  GeneratedColumn<double> get preferredWeightIncrementKg => $composableBuilder(
      column: $table.preferredWeightIncrementKg, builder: (column) => column);

  GeneratedColumn<bool> get restTimerEnabled => $composableBuilder(
      column: $table.restTimerEnabled, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RecommendationStyle?, String>
      get recommendationStyle => $composableBuilder(
          column: $table.recommendationStyle, builder: (column) => column);

  GeneratedColumn<int> get autoEndTimeoutMinutes => $composableBuilder(
      column: $table.autoEndTimeoutMinutes, builder: (column) => column);

  GeneratedColumn<bool> get restNotificationsEnabled => $composableBuilder(
      column: $table.restNotificationsEnabled, builder: (column) => column);

  GeneratedColumn<bool> get soundEnabled => $composableBuilder(
      column: $table.soundEnabled, builder: (column) => column);

  GeneratedColumn<bool> get vibrationEnabled => $composableBuilder(
      column: $table.vibrationEnabled, builder: (column) => column);

  GeneratedColumn<int> get defaultAddRestSeconds => $composableBuilder(
      column: $table.defaultAddRestSeconds, builder: (column) => column);

  GeneratedColumn<bool> get showRpeRir => $composableBuilder(
      column: $table.showRpeRir, builder: (column) => column);

  GeneratedColumn<double> get dumbbellIncrementKg => $composableBuilder(
      column: $table.dumbbellIncrementKg, builder: (column) => column);

  GeneratedColumn<double> get barbellIncrementKg => $composableBuilder(
      column: $table.barbellIncrementKg, builder: (column) => column);

  GeneratedColumn<double> get machineIncrementKg => $composableBuilder(
      column: $table.machineIncrementKg, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfileRow,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (
      UserProfileRow,
      BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfileRow>
    ),
    UserProfileRow,
    PrefetchHooks Function()> {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int?> age = const Value.absent(),
            Value<String?> sex = const Value.absent(),
            Value<double?> heightCm = const Value.absent(),
            Value<double?> bodyWeightKg = const Value.absent(),
            Value<TrainingExperience> trainingExperience = const Value.absent(),
            Value<TrainingGoal> primaryGoal = const Value.absent(),
            Value<double> preferredWeightIncrementKg = const Value.absent(),
            Value<bool> restTimerEnabled = const Value.absent(),
            Value<RecommendationStyle?> recommendationStyle =
                const Value.absent(),
            Value<int?> autoEndTimeoutMinutes = const Value.absent(),
            Value<bool?> restNotificationsEnabled = const Value.absent(),
            Value<bool?> soundEnabled = const Value.absent(),
            Value<bool?> vibrationEnabled = const Value.absent(),
            Value<int?> defaultAddRestSeconds = const Value.absent(),
            Value<bool?> showRpeRir = const Value.absent(),
            Value<double?> dumbbellIncrementKg = const Value.absent(),
            Value<double?> barbellIncrementKg = const Value.absent(),
            Value<double?> machineIncrementKg = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfilesCompanion(
            id: id,
            name: name,
            age: age,
            sex: sex,
            heightCm: heightCm,
            bodyWeightKg: bodyWeightKg,
            trainingExperience: trainingExperience,
            primaryGoal: primaryGoal,
            preferredWeightIncrementKg: preferredWeightIncrementKg,
            restTimerEnabled: restTimerEnabled,
            recommendationStyle: recommendationStyle,
            autoEndTimeoutMinutes: autoEndTimeoutMinutes,
            restNotificationsEnabled: restNotificationsEnabled,
            soundEnabled: soundEnabled,
            vibrationEnabled: vibrationEnabled,
            defaultAddRestSeconds: defaultAddRestSeconds,
            showRpeRir: showRpeRir,
            dumbbellIncrementKg: dumbbellIncrementKg,
            barbellIncrementKg: barbellIncrementKg,
            machineIncrementKg: machineIncrementKg,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int?> age = const Value.absent(),
            Value<String?> sex = const Value.absent(),
            Value<double?> heightCm = const Value.absent(),
            Value<double?> bodyWeightKg = const Value.absent(),
            required TrainingExperience trainingExperience,
            required TrainingGoal primaryGoal,
            required double preferredWeightIncrementKg,
            Value<bool> restTimerEnabled = const Value.absent(),
            Value<RecommendationStyle?> recommendationStyle =
                const Value.absent(),
            Value<int?> autoEndTimeoutMinutes = const Value.absent(),
            Value<bool?> restNotificationsEnabled = const Value.absent(),
            Value<bool?> soundEnabled = const Value.absent(),
            Value<bool?> vibrationEnabled = const Value.absent(),
            Value<int?> defaultAddRestSeconds = const Value.absent(),
            Value<bool?> showRpeRir = const Value.absent(),
            Value<double?> dumbbellIncrementKg = const Value.absent(),
            Value<double?> barbellIncrementKg = const Value.absent(),
            Value<double?> machineIncrementKg = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfilesCompanion.insert(
            id: id,
            name: name,
            age: age,
            sex: sex,
            heightCm: heightCm,
            bodyWeightKg: bodyWeightKg,
            trainingExperience: trainingExperience,
            primaryGoal: primaryGoal,
            preferredWeightIncrementKg: preferredWeightIncrementKg,
            restTimerEnabled: restTimerEnabled,
            recommendationStyle: recommendationStyle,
            autoEndTimeoutMinutes: autoEndTimeoutMinutes,
            restNotificationsEnabled: restNotificationsEnabled,
            soundEnabled: soundEnabled,
            vibrationEnabled: vibrationEnabled,
            defaultAddRestSeconds: defaultAddRestSeconds,
            showRpeRir: showRpeRir,
            dumbbellIncrementKg: dumbbellIncrementKg,
            barbellIncrementKg: barbellIncrementKg,
            machineIncrementKg: machineIncrementKg,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfileRow,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (
      UserProfileRow,
      BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfileRow>
    ),
    UserProfileRow,
    PrefetchHooks Function()>;
typedef $$ExercisesTableCreateCompanionBuilder = ExercisesCompanion Function({
  required String id,
  required String name,
  Value<DayType?> dayType,
  Value<String> tags,
  required String primaryMuscleGroup,
  Value<String> secondaryMuscleGroups,
  Value<String> movementPattern,
  required EquipmentType equipmentType,
  Value<ExerciseCategory?> exerciseCategory,
  Value<bool> isBodyweight,
  Value<bool> isUnilateral,
  Value<double?> defaultIncrementKg,
  Value<int?> minimumRecommendedReps,
  Value<int?> maximumRecommendedReps,
  Value<int?> defaultRestSeconds,
  Value<int?> recommendedSetRangeMin,
  Value<int?> recommendedSetRangeMax,
  Value<String?> notes,
  Value<bool> isCustom,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ExercisesTableUpdateCompanionBuilder = ExercisesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<DayType?> dayType,
  Value<String> tags,
  Value<String> primaryMuscleGroup,
  Value<String> secondaryMuscleGroups,
  Value<String> movementPattern,
  Value<EquipmentType> equipmentType,
  Value<ExerciseCategory?> exerciseCategory,
  Value<bool> isBodyweight,
  Value<bool> isUnilateral,
  Value<double?> defaultIncrementKg,
  Value<int?> minimumRecommendedReps,
  Value<int?> maximumRecommendedReps,
  Value<int?> defaultRestSeconds,
  Value<int?> recommendedSetRangeMin,
  Value<int?> recommendedSetRangeMax,
  Value<String?> notes,
  Value<bool> isCustom,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<DayType?, DayType, String> get dayType =>
      $composableBuilder(
          column: $table.dayType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get primaryMuscleGroup => $composableBuilder(
      column: $table.primaryMuscleGroup,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get secondaryMuscleGroups => $composableBuilder(
      column: $table.secondaryMuscleGroups,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get movementPattern => $composableBuilder(
      column: $table.movementPattern,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<EquipmentType, EquipmentType, String>
      get equipmentType => $composableBuilder(
          column: $table.equipmentType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<ExerciseCategory?, ExerciseCategory, String>
      get exerciseCategory => $composableBuilder(
          column: $table.exerciseCategory,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get isBodyweight => $composableBuilder(
      column: $table.isBodyweight, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isUnilateral => $composableBuilder(
      column: $table.isUnilateral, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get defaultIncrementKg => $composableBuilder(
      column: $table.defaultIncrementKg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minimumRecommendedReps => $composableBuilder(
      column: $table.minimumRecommendedReps,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maximumRecommendedReps => $composableBuilder(
      column: $table.maximumRecommendedReps,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get defaultRestSeconds => $composableBuilder(
      column: $table.defaultRestSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get recommendedSetRangeMin => $composableBuilder(
      column: $table.recommendedSetRangeMin,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get recommendedSetRangeMax => $composableBuilder(
      column: $table.recommendedSetRangeMax,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCustom => $composableBuilder(
      column: $table.isCustom, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dayType => $composableBuilder(
      column: $table.dayType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get primaryMuscleGroup => $composableBuilder(
      column: $table.primaryMuscleGroup,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get secondaryMuscleGroups => $composableBuilder(
      column: $table.secondaryMuscleGroups,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get movementPattern => $composableBuilder(
      column: $table.movementPattern,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exerciseCategory => $composableBuilder(
      column: $table.exerciseCategory,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isBodyweight => $composableBuilder(
      column: $table.isBodyweight,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isUnilateral => $composableBuilder(
      column: $table.isUnilateral,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get defaultIncrementKg => $composableBuilder(
      column: $table.defaultIncrementKg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minimumRecommendedReps => $composableBuilder(
      column: $table.minimumRecommendedReps,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maximumRecommendedReps => $composableBuilder(
      column: $table.maximumRecommendedReps,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get defaultRestSeconds => $composableBuilder(
      column: $table.defaultRestSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get recommendedSetRangeMin => $composableBuilder(
      column: $table.recommendedSetRangeMin,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get recommendedSetRangeMax => $composableBuilder(
      column: $table.recommendedSetRangeMax,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCustom => $composableBuilder(
      column: $table.isCustom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DayType?, String> get dayType =>
      $composableBuilder(column: $table.dayType, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get primaryMuscleGroup => $composableBuilder(
      column: $table.primaryMuscleGroup, builder: (column) => column);

  GeneratedColumn<String> get secondaryMuscleGroups => $composableBuilder(
      column: $table.secondaryMuscleGroups, builder: (column) => column);

  GeneratedColumn<String> get movementPattern => $composableBuilder(
      column: $table.movementPattern, builder: (column) => column);

  GeneratedColumnWithTypeConverter<EquipmentType, String> get equipmentType =>
      $composableBuilder(
          column: $table.equipmentType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ExerciseCategory?, String>
      get exerciseCategory => $composableBuilder(
          column: $table.exerciseCategory, builder: (column) => column);

  GeneratedColumn<bool> get isBodyweight => $composableBuilder(
      column: $table.isBodyweight, builder: (column) => column);

  GeneratedColumn<bool> get isUnilateral => $composableBuilder(
      column: $table.isUnilateral, builder: (column) => column);

  GeneratedColumn<double> get defaultIncrementKg => $composableBuilder(
      column: $table.defaultIncrementKg, builder: (column) => column);

  GeneratedColumn<int> get minimumRecommendedReps => $composableBuilder(
      column: $table.minimumRecommendedReps, builder: (column) => column);

  GeneratedColumn<int> get maximumRecommendedReps => $composableBuilder(
      column: $table.maximumRecommendedReps, builder: (column) => column);

  GeneratedColumn<int> get defaultRestSeconds => $composableBuilder(
      column: $table.defaultRestSeconds, builder: (column) => column);

  GeneratedColumn<int> get recommendedSetRangeMin => $composableBuilder(
      column: $table.recommendedSetRangeMin, builder: (column) => column);

  GeneratedColumn<int> get recommendedSetRangeMax => $composableBuilder(
      column: $table.recommendedSetRangeMax, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isCustom =>
      $composableBuilder(column: $table.isCustom, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ExercisesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExercisesTable,
    ExerciseRow,
    $$ExercisesTableFilterComposer,
    $$ExercisesTableOrderingComposer,
    $$ExercisesTableAnnotationComposer,
    $$ExercisesTableCreateCompanionBuilder,
    $$ExercisesTableUpdateCompanionBuilder,
    (ExerciseRow, BaseReferences<_$AppDatabase, $ExercisesTable, ExerciseRow>),
    ExerciseRow,
    PrefetchHooks Function()> {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DayType?> dayType = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<String> primaryMuscleGroup = const Value.absent(),
            Value<String> secondaryMuscleGroups = const Value.absent(),
            Value<String> movementPattern = const Value.absent(),
            Value<EquipmentType> equipmentType = const Value.absent(),
            Value<ExerciseCategory?> exerciseCategory = const Value.absent(),
            Value<bool> isBodyweight = const Value.absent(),
            Value<bool> isUnilateral = const Value.absent(),
            Value<double?> defaultIncrementKg = const Value.absent(),
            Value<int?> minimumRecommendedReps = const Value.absent(),
            Value<int?> maximumRecommendedReps = const Value.absent(),
            Value<int?> defaultRestSeconds = const Value.absent(),
            Value<int?> recommendedSetRangeMin = const Value.absent(),
            Value<int?> recommendedSetRangeMax = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isCustom = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExercisesCompanion(
            id: id,
            name: name,
            dayType: dayType,
            tags: tags,
            primaryMuscleGroup: primaryMuscleGroup,
            secondaryMuscleGroups: secondaryMuscleGroups,
            movementPattern: movementPattern,
            equipmentType: equipmentType,
            exerciseCategory: exerciseCategory,
            isBodyweight: isBodyweight,
            isUnilateral: isUnilateral,
            defaultIncrementKg: defaultIncrementKg,
            minimumRecommendedReps: minimumRecommendedReps,
            maximumRecommendedReps: maximumRecommendedReps,
            defaultRestSeconds: defaultRestSeconds,
            recommendedSetRangeMin: recommendedSetRangeMin,
            recommendedSetRangeMax: recommendedSetRangeMax,
            notes: notes,
            isCustom: isCustom,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<DayType?> dayType = const Value.absent(),
            Value<String> tags = const Value.absent(),
            required String primaryMuscleGroup,
            Value<String> secondaryMuscleGroups = const Value.absent(),
            Value<String> movementPattern = const Value.absent(),
            required EquipmentType equipmentType,
            Value<ExerciseCategory?> exerciseCategory = const Value.absent(),
            Value<bool> isBodyweight = const Value.absent(),
            Value<bool> isUnilateral = const Value.absent(),
            Value<double?> defaultIncrementKg = const Value.absent(),
            Value<int?> minimumRecommendedReps = const Value.absent(),
            Value<int?> maximumRecommendedReps = const Value.absent(),
            Value<int?> defaultRestSeconds = const Value.absent(),
            Value<int?> recommendedSetRangeMin = const Value.absent(),
            Value<int?> recommendedSetRangeMax = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isCustom = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ExercisesCompanion.insert(
            id: id,
            name: name,
            dayType: dayType,
            tags: tags,
            primaryMuscleGroup: primaryMuscleGroup,
            secondaryMuscleGroups: secondaryMuscleGroups,
            movementPattern: movementPattern,
            equipmentType: equipmentType,
            exerciseCategory: exerciseCategory,
            isBodyweight: isBodyweight,
            isUnilateral: isUnilateral,
            defaultIncrementKg: defaultIncrementKg,
            minimumRecommendedReps: minimumRecommendedReps,
            maximumRecommendedReps: maximumRecommendedReps,
            defaultRestSeconds: defaultRestSeconds,
            recommendedSetRangeMin: recommendedSetRangeMin,
            recommendedSetRangeMax: recommendedSetRangeMax,
            notes: notes,
            isCustom: isCustom,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExercisesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExercisesTable,
    ExerciseRow,
    $$ExercisesTableFilterComposer,
    $$ExercisesTableOrderingComposer,
    $$ExercisesTableAnnotationComposer,
    $$ExercisesTableCreateCompanionBuilder,
    $$ExercisesTableUpdateCompanionBuilder,
    (ExerciseRow, BaseReferences<_$AppDatabase, $ExercisesTable, ExerciseRow>),
    ExerciseRow,
    PrefetchHooks Function()>;
typedef $$WorkoutSessionsTableCreateCompanionBuilder = WorkoutSessionsCompanion
    Function({
  required String id,
  required String userProfileId,
  Value<DayType?> dayType,
  Value<String?> sessionName,
  Value<String> tags,
  required DateTime startedAt,
  Value<DateTime?> endedAt,
  required DateTime lastActivityAt,
  required WorkoutSessionStatus status,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$WorkoutSessionsTableUpdateCompanionBuilder = WorkoutSessionsCompanion
    Function({
  Value<String> id,
  Value<String> userProfileId,
  Value<DayType?> dayType,
  Value<String?> sessionName,
  Value<String> tags,
  Value<DateTime> startedAt,
  Value<DateTime?> endedAt,
  Value<DateTime> lastActivityAt,
  Value<WorkoutSessionStatus> status,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$WorkoutSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userProfileId => $composableBuilder(
      column: $table.userProfileId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<DayType?, DayType, String> get dayType =>
      $composableBuilder(
          column: $table.dayType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get sessionName => $composableBuilder(
      column: $table.sessionName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
      column: $table.endedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastActivityAt => $composableBuilder(
      column: $table.lastActivityAt,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<WorkoutSessionStatus, WorkoutSessionStatus,
          String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$WorkoutSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userProfileId => $composableBuilder(
      column: $table.userProfileId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dayType => $composableBuilder(
      column: $table.dayType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sessionName => $composableBuilder(
      column: $table.sessionName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
      column: $table.endedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastActivityAt => $composableBuilder(
      column: $table.lastActivityAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$WorkoutSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userProfileId => $composableBuilder(
      column: $table.userProfileId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DayType?, String> get dayType =>
      $composableBuilder(column: $table.dayType, builder: (column) => column);

  GeneratedColumn<String> get sessionName => $composableBuilder(
      column: $table.sessionName, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastActivityAt => $composableBuilder(
      column: $table.lastActivityAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WorkoutSessionStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WorkoutSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutSessionsTable,
    WorkoutSessionRow,
    $$WorkoutSessionsTableFilterComposer,
    $$WorkoutSessionsTableOrderingComposer,
    $$WorkoutSessionsTableAnnotationComposer,
    $$WorkoutSessionsTableCreateCompanionBuilder,
    $$WorkoutSessionsTableUpdateCompanionBuilder,
    (
      WorkoutSessionRow,
      BaseReferences<_$AppDatabase, $WorkoutSessionsTable, WorkoutSessionRow>
    ),
    WorkoutSessionRow,
    PrefetchHooks Function()> {
  $$WorkoutSessionsTableTableManager(
      _$AppDatabase db, $WorkoutSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userProfileId = const Value.absent(),
            Value<DayType?> dayType = const Value.absent(),
            Value<String?> sessionName = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
            Value<DateTime?> endedAt = const Value.absent(),
            Value<DateTime> lastActivityAt = const Value.absent(),
            Value<WorkoutSessionStatus> status = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutSessionsCompanion(
            id: id,
            userProfileId: userProfileId,
            dayType: dayType,
            sessionName: sessionName,
            tags: tags,
            startedAt: startedAt,
            endedAt: endedAt,
            lastActivityAt: lastActivityAt,
            status: status,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userProfileId,
            Value<DayType?> dayType = const Value.absent(),
            Value<String?> sessionName = const Value.absent(),
            Value<String> tags = const Value.absent(),
            required DateTime startedAt,
            Value<DateTime?> endedAt = const Value.absent(),
            required DateTime lastActivityAt,
            required WorkoutSessionStatus status,
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutSessionsCompanion.insert(
            id: id,
            userProfileId: userProfileId,
            dayType: dayType,
            sessionName: sessionName,
            tags: tags,
            startedAt: startedAt,
            endedAt: endedAt,
            lastActivityAt: lastActivityAt,
            status: status,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorkoutSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutSessionsTable,
    WorkoutSessionRow,
    $$WorkoutSessionsTableFilterComposer,
    $$WorkoutSessionsTableOrderingComposer,
    $$WorkoutSessionsTableAnnotationComposer,
    $$WorkoutSessionsTableCreateCompanionBuilder,
    $$WorkoutSessionsTableUpdateCompanionBuilder,
    (
      WorkoutSessionRow,
      BaseReferences<_$AppDatabase, $WorkoutSessionsTable, WorkoutSessionRow>
    ),
    WorkoutSessionRow,
    PrefetchHooks Function()>;
typedef $$WorkoutExercisesTableCreateCompanionBuilder
    = WorkoutExercisesCompanion Function({
  required String id,
  required String sessionId,
  required String exerciseId,
  required int orderIndex,
  Value<DateTime?> startedAt,
  Value<DateTime?> endedAt,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$WorkoutExercisesTableUpdateCompanionBuilder
    = WorkoutExercisesCompanion Function({
  Value<String> id,
  Value<String> sessionId,
  Value<String> exerciseId,
  Value<int> orderIndex,
  Value<DateTime?> startedAt,
  Value<DateTime?> endedAt,
  Value<String?> notes,
  Value<int> rowid,
});

class $$WorkoutExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutExercisesTable> {
  $$WorkoutExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
      column: $table.endedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$WorkoutExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutExercisesTable> {
  $$WorkoutExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
      column: $table.endedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$WorkoutExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutExercisesTable> {
  $$WorkoutExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$WorkoutExercisesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutExercisesTable,
    WorkoutExerciseRow,
    $$WorkoutExercisesTableFilterComposer,
    $$WorkoutExercisesTableOrderingComposer,
    $$WorkoutExercisesTableAnnotationComposer,
    $$WorkoutExercisesTableCreateCompanionBuilder,
    $$WorkoutExercisesTableUpdateCompanionBuilder,
    (
      WorkoutExerciseRow,
      BaseReferences<_$AppDatabase, $WorkoutExercisesTable, WorkoutExerciseRow>
    ),
    WorkoutExerciseRow,
    PrefetchHooks Function()> {
  $$WorkoutExercisesTableTableManager(
      _$AppDatabase db, $WorkoutExercisesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sessionId = const Value.absent(),
            Value<String> exerciseId = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<DateTime?> startedAt = const Value.absent(),
            Value<DateTime?> endedAt = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutExercisesCompanion(
            id: id,
            sessionId: sessionId,
            exerciseId: exerciseId,
            orderIndex: orderIndex,
            startedAt: startedAt,
            endedAt: endedAt,
            notes: notes,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sessionId,
            required String exerciseId,
            required int orderIndex,
            Value<DateTime?> startedAt = const Value.absent(),
            Value<DateTime?> endedAt = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutExercisesCompanion.insert(
            id: id,
            sessionId: sessionId,
            exerciseId: exerciseId,
            orderIndex: orderIndex,
            startedAt: startedAt,
            endedAt: endedAt,
            notes: notes,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorkoutExercisesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutExercisesTable,
    WorkoutExerciseRow,
    $$WorkoutExercisesTableFilterComposer,
    $$WorkoutExercisesTableOrderingComposer,
    $$WorkoutExercisesTableAnnotationComposer,
    $$WorkoutExercisesTableCreateCompanionBuilder,
    $$WorkoutExercisesTableUpdateCompanionBuilder,
    (
      WorkoutExerciseRow,
      BaseReferences<_$AppDatabase, $WorkoutExercisesTable, WorkoutExerciseRow>
    ),
    WorkoutExerciseRow,
    PrefetchHooks Function()>;
typedef $$WorkoutSetsTableCreateCompanionBuilder = WorkoutSetsCompanion
    Function({
  required String id,
  required String workoutExerciseId,
  required int setNumber,
  required double weightKg,
  required int reps,
  Value<double?> rpe,
  Value<int?> rir,
  Value<bool> isWarmup,
  Value<bool> isFailure,
  Value<double?> estimatedOneRepMaxKg,
  Value<int?> restBeforeSetSeconds,
  Value<int?> restAfterSetSeconds,
  Value<DateTime?> startedAt,
  Value<DateTime?> completedAt,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$WorkoutSetsTableUpdateCompanionBuilder = WorkoutSetsCompanion
    Function({
  Value<String> id,
  Value<String> workoutExerciseId,
  Value<int> setNumber,
  Value<double> weightKg,
  Value<int> reps,
  Value<WorkoutSetLoadType> loadType,
  Value<double?> rpe,
  Value<int?> rir,
  Value<bool> isWarmup,
  Value<bool> isFailure,
  Value<double?> estimatedOneRepMaxKg,
  Value<int?> restBeforeSetSeconds,
  Value<int?> restAfterSetSeconds,
  Value<DateTime?> startedAt,
  Value<DateTime?> completedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String?> notes,
  Value<int> rowid,
});

class $$WorkoutSetsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workoutExerciseId => $composableBuilder(
      column: $table.workoutExerciseId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get setNumber => $composableBuilder(
      column: $table.setNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<WorkoutSetLoadType, WorkoutSetLoadType, String>
      get loadType => $composableBuilder(
          column: $table.loadType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get rpe => $composableBuilder(
      column: $table.rpe, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rir => $composableBuilder(
      column: $table.rir, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isWarmup => $composableBuilder(
      column: $table.isWarmup, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFailure => $composableBuilder(
      column: $table.isFailure, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get estimatedOneRepMaxKg => $composableBuilder(
      column: $table.estimatedOneRepMaxKg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get restBeforeSetSeconds => $composableBuilder(
      column: $table.restBeforeSetSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get restAfterSetSeconds => $composableBuilder(
      column: $table.restAfterSetSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$WorkoutSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workoutExerciseId => $composableBuilder(
      column: $table.workoutExerciseId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get setNumber => $composableBuilder(
      column: $table.setNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get loadType => $composableBuilder(
      column: $table.loadType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rpe => $composableBuilder(
      column: $table.rpe, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rir => $composableBuilder(
      column: $table.rir, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isWarmup => $composableBuilder(
      column: $table.isWarmup, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFailure => $composableBuilder(
      column: $table.isFailure, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get estimatedOneRepMaxKg => $composableBuilder(
      column: $table.estimatedOneRepMaxKg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get restBeforeSetSeconds => $composableBuilder(
      column: $table.restBeforeSetSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get restAfterSetSeconds => $composableBuilder(
      column: $table.restAfterSetSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$WorkoutSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workoutExerciseId => $composableBuilder(
      column: $table.workoutExerciseId, builder: (column) => column);

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WorkoutSetLoadType, String> get loadType =>
      $composableBuilder(column: $table.loadType, builder: (column) => column);

  GeneratedColumn<double> get rpe =>
      $composableBuilder(column: $table.rpe, builder: (column) => column);

  GeneratedColumn<int> get rir =>
      $composableBuilder(column: $table.rir, builder: (column) => column);

  GeneratedColumn<bool> get isWarmup =>
      $composableBuilder(column: $table.isWarmup, builder: (column) => column);

  GeneratedColumn<bool> get isFailure =>
      $composableBuilder(column: $table.isFailure, builder: (column) => column);

  GeneratedColumn<double> get estimatedOneRepMaxKg => $composableBuilder(
      column: $table.estimatedOneRepMaxKg, builder: (column) => column);

  GeneratedColumn<int> get restBeforeSetSeconds => $composableBuilder(
      column: $table.restBeforeSetSeconds, builder: (column) => column);

  GeneratedColumn<int> get restAfterSetSeconds => $composableBuilder(
      column: $table.restAfterSetSeconds, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$WorkoutSetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutSetsTable,
    WorkoutSetRow,
    $$WorkoutSetsTableFilterComposer,
    $$WorkoutSetsTableOrderingComposer,
    $$WorkoutSetsTableAnnotationComposer,
    $$WorkoutSetsTableCreateCompanionBuilder,
    $$WorkoutSetsTableUpdateCompanionBuilder,
    (
      WorkoutSetRow,
      BaseReferences<_$AppDatabase, $WorkoutSetsTable, WorkoutSetRow>
    ),
    WorkoutSetRow,
    PrefetchHooks Function()> {
  $$WorkoutSetsTableTableManager(_$AppDatabase db, $WorkoutSetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workoutExerciseId = const Value.absent(),
            Value<int> setNumber = const Value.absent(),
            Value<double> weightKg = const Value.absent(),
            Value<int> reps = const Value.absent(),
            Value<WorkoutSetLoadType> loadType = const Value.absent(),
            Value<double?> rpe = const Value.absent(),
            Value<int?> rir = const Value.absent(),
            Value<bool> isWarmup = const Value.absent(),
            Value<bool> isFailure = const Value.absent(),
            Value<double?> estimatedOneRepMaxKg = const Value.absent(),
            Value<int?> restBeforeSetSeconds = const Value.absent(),
            Value<int?> restAfterSetSeconds = const Value.absent(),
            Value<DateTime?> startedAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutSetsCompanion(
            id: id,
            workoutExerciseId: workoutExerciseId,
            setNumber: setNumber,
            weightKg: weightKg,
            reps: reps,
            loadType: loadType,
            rpe: rpe,
            rir: rir,
            isWarmup: isWarmup,
            isFailure: isFailure,
            estimatedOneRepMaxKg: estimatedOneRepMaxKg,
            restBeforeSetSeconds: restBeforeSetSeconds,
            restAfterSetSeconds: restAfterSetSeconds,
            startedAt: startedAt,
            completedAt: completedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            notes: notes,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workoutExerciseId,
            required int setNumber,
            required double weightKg,
            required int reps,
            Value<WorkoutSetLoadType> loadType = const Value.absent(),
            Value<double?> rpe = const Value.absent(),
            Value<int?> rir = const Value.absent(),
            Value<bool> isWarmup = const Value.absent(),
            Value<bool> isFailure = const Value.absent(),
            Value<double?> estimatedOneRepMaxKg = const Value.absent(),
            Value<int?> restBeforeSetSeconds = const Value.absent(),
            Value<int?> restAfterSetSeconds = const Value.absent(),
            Value<DateTime?> startedAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutSetsCompanion.insert(
            id: id,
            workoutExerciseId: workoutExerciseId,
            setNumber: setNumber,
            weightKg: weightKg,
            reps: reps,
            loadType: loadType,
            rpe: rpe,
            rir: rir,
            isWarmup: isWarmup,
            isFailure: isFailure,
            estimatedOneRepMaxKg: estimatedOneRepMaxKg,
            restBeforeSetSeconds: restBeforeSetSeconds,
            restAfterSetSeconds: restAfterSetSeconds,
            startedAt: startedAt,
            completedAt: completedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            notes: notes,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorkoutSetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutSetsTable,
    WorkoutSetRow,
    $$WorkoutSetsTableFilterComposer,
    $$WorkoutSetsTableOrderingComposer,
    $$WorkoutSetsTableAnnotationComposer,
    $$WorkoutSetsTableCreateCompanionBuilder,
    $$WorkoutSetsTableUpdateCompanionBuilder,
    (
      WorkoutSetRow,
      BaseReferences<_$AppDatabase, $WorkoutSetsTable, WorkoutSetRow>
    ),
    WorkoutSetRow,
    PrefetchHooks Function()>;
typedef $$RestTimerStatesTableCreateCompanionBuilder = RestTimerStatesCompanion
    Function({
  required String sessionId,
  Value<String?> exerciseId,
  Value<String?> afterSetId,
  required DateTime startedAt,
  required DateTime endsAt,
  required int totalSeconds,
  Value<bool> isRunning,
  Value<bool> isPaused,
  Value<DateTime?> pausedAt,
  Value<int> accumulatedPausedSeconds,
  Value<bool> allowSilentNotification,
  Value<int> rowid,
});
typedef $$RestTimerStatesTableUpdateCompanionBuilder = RestTimerStatesCompanion
    Function({
  Value<String> sessionId,
  Value<String?> exerciseId,
  Value<String?> afterSetId,
  Value<DateTime> startedAt,
  Value<DateTime> endsAt,
  Value<int> totalSeconds,
  Value<bool> isRunning,
  Value<bool> isPaused,
  Value<DateTime?> pausedAt,
  Value<int> accumulatedPausedSeconds,
  Value<bool> allowSilentNotification,
  Value<int> rowid,
});

class $$RestTimerStatesTableFilterComposer
    extends Composer<_$AppDatabase, $RestTimerStatesTable> {
  $$RestTimerStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get afterSetId => $composableBuilder(
      column: $table.afterSetId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endsAt => $composableBuilder(
      column: $table.endsAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalSeconds => $composableBuilder(
      column: $table.totalSeconds, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRunning => $composableBuilder(
      column: $table.isRunning, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPaused => $composableBuilder(
      column: $table.isPaused, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get pausedAt => $composableBuilder(
      column: $table.pausedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get accumulatedPausedSeconds => $composableBuilder(
      column: $table.accumulatedPausedSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get allowSilentNotification => $composableBuilder(
      column: $table.allowSilentNotification,
      builder: (column) => ColumnFilters(column));
}

class $$RestTimerStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $RestTimerStatesTable> {
  $$RestTimerStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get afterSetId => $composableBuilder(
      column: $table.afterSetId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endsAt => $composableBuilder(
      column: $table.endsAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalSeconds => $composableBuilder(
      column: $table.totalSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRunning => $composableBuilder(
      column: $table.isRunning, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPaused => $composableBuilder(
      column: $table.isPaused, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get pausedAt => $composableBuilder(
      column: $table.pausedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get accumulatedPausedSeconds => $composableBuilder(
      column: $table.accumulatedPausedSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get allowSilentNotification => $composableBuilder(
      column: $table.allowSilentNotification,
      builder: (column) => ColumnOrderings(column));
}

class $$RestTimerStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RestTimerStatesTable> {
  $$RestTimerStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => column);

  GeneratedColumn<String> get afterSetId => $composableBuilder(
      column: $table.afterSetId, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endsAt =>
      $composableBuilder(column: $table.endsAt, builder: (column) => column);

  GeneratedColumn<int> get totalSeconds => $composableBuilder(
      column: $table.totalSeconds, builder: (column) => column);

  GeneratedColumn<bool> get isRunning =>
      $composableBuilder(column: $table.isRunning, builder: (column) => column);

  GeneratedColumn<bool> get isPaused =>
      $composableBuilder(column: $table.isPaused, builder: (column) => column);

  GeneratedColumn<DateTime> get pausedAt =>
      $composableBuilder(column: $table.pausedAt, builder: (column) => column);

  GeneratedColumn<int> get accumulatedPausedSeconds => $composableBuilder(
      column: $table.accumulatedPausedSeconds, builder: (column) => column);

  GeneratedColumn<bool> get allowSilentNotification => $composableBuilder(
      column: $table.allowSilentNotification, builder: (column) => column);
}

class $$RestTimerStatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RestTimerStatesTable,
    RestTimerStateRow,
    $$RestTimerStatesTableFilterComposer,
    $$RestTimerStatesTableOrderingComposer,
    $$RestTimerStatesTableAnnotationComposer,
    $$RestTimerStatesTableCreateCompanionBuilder,
    $$RestTimerStatesTableUpdateCompanionBuilder,
    (
      RestTimerStateRow,
      BaseReferences<_$AppDatabase, $RestTimerStatesTable, RestTimerStateRow>
    ),
    RestTimerStateRow,
    PrefetchHooks Function()> {
  $$RestTimerStatesTableTableManager(
      _$AppDatabase db, $RestTimerStatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RestTimerStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RestTimerStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RestTimerStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> sessionId = const Value.absent(),
            Value<String?> exerciseId = const Value.absent(),
            Value<String?> afterSetId = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
            Value<DateTime> endsAt = const Value.absent(),
            Value<int> totalSeconds = const Value.absent(),
            Value<bool> isRunning = const Value.absent(),
            Value<bool> isPaused = const Value.absent(),
            Value<DateTime?> pausedAt = const Value.absent(),
            Value<int> accumulatedPausedSeconds = const Value.absent(),
            Value<bool> allowSilentNotification = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RestTimerStatesCompanion(
            sessionId: sessionId,
            exerciseId: exerciseId,
            afterSetId: afterSetId,
            startedAt: startedAt,
            endsAt: endsAt,
            totalSeconds: totalSeconds,
            isRunning: isRunning,
            isPaused: isPaused,
            pausedAt: pausedAt,
            accumulatedPausedSeconds: accumulatedPausedSeconds,
            allowSilentNotification: allowSilentNotification,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String sessionId,
            Value<String?> exerciseId = const Value.absent(),
            Value<String?> afterSetId = const Value.absent(),
            required DateTime startedAt,
            required DateTime endsAt,
            required int totalSeconds,
            Value<bool> isRunning = const Value.absent(),
            Value<bool> isPaused = const Value.absent(),
            Value<DateTime?> pausedAt = const Value.absent(),
            Value<int> accumulatedPausedSeconds = const Value.absent(),
            Value<bool> allowSilentNotification = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RestTimerStatesCompanion.insert(
            sessionId: sessionId,
            exerciseId: exerciseId,
            afterSetId: afterSetId,
            startedAt: startedAt,
            endsAt: endsAt,
            totalSeconds: totalSeconds,
            isRunning: isRunning,
            isPaused: isPaused,
            pausedAt: pausedAt,
            accumulatedPausedSeconds: accumulatedPausedSeconds,
            allowSilentNotification: allowSilentNotification,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RestTimerStatesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RestTimerStatesTable,
    RestTimerStateRow,
    $$RestTimerStatesTableFilterComposer,
    $$RestTimerStatesTableOrderingComposer,
    $$RestTimerStatesTableAnnotationComposer,
    $$RestTimerStatesTableCreateCompanionBuilder,
    $$RestTimerStatesTableUpdateCompanionBuilder,
    (
      RestTimerStateRow,
      BaseReferences<_$AppDatabase, $RestTimerStatesTable, RestTimerStateRow>
    ),
    RestTimerStateRow,
    PrefetchHooks Function()>;
typedef $$ExerciseMuscleTargetsTableCreateCompanionBuilder
    = ExerciseMuscleTargetsCompanion Function({
  required String id,
  required String exerciseId,
  required MuscleGroup muscleGroup,
  required MuscleRole role,
  required double contribution,
  Value<int> rowid,
});
typedef $$ExerciseMuscleTargetsTableUpdateCompanionBuilder
    = ExerciseMuscleTargetsCompanion Function({
  Value<String> id,
  Value<String> exerciseId,
  Value<MuscleGroup> muscleGroup,
  Value<MuscleRole> role,
  Value<double> contribution,
  Value<int> rowid,
});

class $$ExerciseMuscleTargetsTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseMuscleTargetsTable> {
  $$ExerciseMuscleTargetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MuscleGroup, MuscleGroup, String>
      get muscleGroup => $composableBuilder(
          column: $table.muscleGroup,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<MuscleRole, MuscleRole, String> get role =>
      $composableBuilder(
          column: $table.role,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get contribution => $composableBuilder(
      column: $table.contribution, builder: (column) => ColumnFilters(column));
}

class $$ExerciseMuscleTargetsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseMuscleTargetsTable> {
  $$ExerciseMuscleTargetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get muscleGroup => $composableBuilder(
      column: $table.muscleGroup, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get contribution => $composableBuilder(
      column: $table.contribution,
      builder: (column) => ColumnOrderings(column));
}

class $$ExerciseMuscleTargetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseMuscleTargetsTable> {
  $$ExerciseMuscleTargetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MuscleGroup, String> get muscleGroup =>
      $composableBuilder(
          column: $table.muscleGroup, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MuscleRole, String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<double> get contribution => $composableBuilder(
      column: $table.contribution, builder: (column) => column);
}

class $$ExerciseMuscleTargetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExerciseMuscleTargetsTable,
    ExerciseMuscleTargetRow,
    $$ExerciseMuscleTargetsTableFilterComposer,
    $$ExerciseMuscleTargetsTableOrderingComposer,
    $$ExerciseMuscleTargetsTableAnnotationComposer,
    $$ExerciseMuscleTargetsTableCreateCompanionBuilder,
    $$ExerciseMuscleTargetsTableUpdateCompanionBuilder,
    (
      ExerciseMuscleTargetRow,
      BaseReferences<_$AppDatabase, $ExerciseMuscleTargetsTable,
          ExerciseMuscleTargetRow>
    ),
    ExerciseMuscleTargetRow,
    PrefetchHooks Function()> {
  $$ExerciseMuscleTargetsTableTableManager(
      _$AppDatabase db, $ExerciseMuscleTargetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseMuscleTargetsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseMuscleTargetsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseMuscleTargetsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> exerciseId = const Value.absent(),
            Value<MuscleGroup> muscleGroup = const Value.absent(),
            Value<MuscleRole> role = const Value.absent(),
            Value<double> contribution = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExerciseMuscleTargetsCompanion(
            id: id,
            exerciseId: exerciseId,
            muscleGroup: muscleGroup,
            role: role,
            contribution: contribution,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String exerciseId,
            required MuscleGroup muscleGroup,
            required MuscleRole role,
            required double contribution,
            Value<int> rowid = const Value.absent(),
          }) =>
              ExerciseMuscleTargetsCompanion.insert(
            id: id,
            exerciseId: exerciseId,
            muscleGroup: muscleGroup,
            role: role,
            contribution: contribution,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExerciseMuscleTargetsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ExerciseMuscleTargetsTable,
        ExerciseMuscleTargetRow,
        $$ExerciseMuscleTargetsTableFilterComposer,
        $$ExerciseMuscleTargetsTableOrderingComposer,
        $$ExerciseMuscleTargetsTableAnnotationComposer,
        $$ExerciseMuscleTargetsTableCreateCompanionBuilder,
        $$ExerciseMuscleTargetsTableUpdateCompanionBuilder,
        (
          ExerciseMuscleTargetRow,
          BaseReferences<_$AppDatabase, $ExerciseMuscleTargetsTable,
              ExerciseMuscleTargetRow>
        ),
        ExerciseMuscleTargetRow,
        PrefetchHooks Function()>;
typedef $$WorkoutMuscleImpactsTableCreateCompanionBuilder
    = WorkoutMuscleImpactsCompanion Function({
  required String id,
  required String sessionId,
  required MuscleGroup muscleGroup,
  required double rawScore,
  required double normalizedScore,
  required int workingSets,
  required double volume,
  required MuscleRole strongestRole,
  Value<int> rowid,
});
typedef $$WorkoutMuscleImpactsTableUpdateCompanionBuilder
    = WorkoutMuscleImpactsCompanion Function({
  Value<String> id,
  Value<String> sessionId,
  Value<MuscleGroup> muscleGroup,
  Value<double> rawScore,
  Value<double> normalizedScore,
  Value<int> workingSets,
  Value<double> volume,
  Value<MuscleRole> strongestRole,
  Value<int> rowid,
});

class $$WorkoutMuscleImpactsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutMuscleImpactsTable> {
  $$WorkoutMuscleImpactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MuscleGroup, MuscleGroup, String>
      get muscleGroup => $composableBuilder(
          column: $table.muscleGroup,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get rawScore => $composableBuilder(
      column: $table.rawScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get normalizedScore => $composableBuilder(
      column: $table.normalizedScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get workingSets => $composableBuilder(
      column: $table.workingSets, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get volume => $composableBuilder(
      column: $table.volume, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MuscleRole, MuscleRole, String>
      get strongestRole => $composableBuilder(
          column: $table.strongestRole,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$WorkoutMuscleImpactsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutMuscleImpactsTable> {
  $$WorkoutMuscleImpactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get muscleGroup => $composableBuilder(
      column: $table.muscleGroup, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rawScore => $composableBuilder(
      column: $table.rawScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get normalizedScore => $composableBuilder(
      column: $table.normalizedScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get workingSets => $composableBuilder(
      column: $table.workingSets, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get volume => $composableBuilder(
      column: $table.volume, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get strongestRole => $composableBuilder(
      column: $table.strongestRole,
      builder: (column) => ColumnOrderings(column));
}

class $$WorkoutMuscleImpactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutMuscleImpactsTable> {
  $$WorkoutMuscleImpactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MuscleGroup, String> get muscleGroup =>
      $composableBuilder(
          column: $table.muscleGroup, builder: (column) => column);

  GeneratedColumn<double> get rawScore =>
      $composableBuilder(column: $table.rawScore, builder: (column) => column);

  GeneratedColumn<double> get normalizedScore => $composableBuilder(
      column: $table.normalizedScore, builder: (column) => column);

  GeneratedColumn<int> get workingSets => $composableBuilder(
      column: $table.workingSets, builder: (column) => column);

  GeneratedColumn<double> get volume =>
      $composableBuilder(column: $table.volume, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MuscleRole, String> get strongestRole =>
      $composableBuilder(
          column: $table.strongestRole, builder: (column) => column);
}

class $$WorkoutMuscleImpactsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutMuscleImpactsTable,
    WorkoutMuscleImpactRow,
    $$WorkoutMuscleImpactsTableFilterComposer,
    $$WorkoutMuscleImpactsTableOrderingComposer,
    $$WorkoutMuscleImpactsTableAnnotationComposer,
    $$WorkoutMuscleImpactsTableCreateCompanionBuilder,
    $$WorkoutMuscleImpactsTableUpdateCompanionBuilder,
    (
      WorkoutMuscleImpactRow,
      BaseReferences<_$AppDatabase, $WorkoutMuscleImpactsTable,
          WorkoutMuscleImpactRow>
    ),
    WorkoutMuscleImpactRow,
    PrefetchHooks Function()> {
  $$WorkoutMuscleImpactsTableTableManager(
      _$AppDatabase db, $WorkoutMuscleImpactsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutMuscleImpactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutMuscleImpactsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutMuscleImpactsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sessionId = const Value.absent(),
            Value<MuscleGroup> muscleGroup = const Value.absent(),
            Value<double> rawScore = const Value.absent(),
            Value<double> normalizedScore = const Value.absent(),
            Value<int> workingSets = const Value.absent(),
            Value<double> volume = const Value.absent(),
            Value<MuscleRole> strongestRole = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutMuscleImpactsCompanion(
            id: id,
            sessionId: sessionId,
            muscleGroup: muscleGroup,
            rawScore: rawScore,
            normalizedScore: normalizedScore,
            workingSets: workingSets,
            volume: volume,
            strongestRole: strongestRole,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sessionId,
            required MuscleGroup muscleGroup,
            required double rawScore,
            required double normalizedScore,
            required int workingSets,
            required double volume,
            required MuscleRole strongestRole,
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutMuscleImpactsCompanion.insert(
            id: id,
            sessionId: sessionId,
            muscleGroup: muscleGroup,
            rawScore: rawScore,
            normalizedScore: normalizedScore,
            workingSets: workingSets,
            volume: volume,
            strongestRole: strongestRole,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorkoutMuscleImpactsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $WorkoutMuscleImpactsTable,
        WorkoutMuscleImpactRow,
        $$WorkoutMuscleImpactsTableFilterComposer,
        $$WorkoutMuscleImpactsTableOrderingComposer,
        $$WorkoutMuscleImpactsTableAnnotationComposer,
        $$WorkoutMuscleImpactsTableCreateCompanionBuilder,
        $$WorkoutMuscleImpactsTableUpdateCompanionBuilder,
        (
          WorkoutMuscleImpactRow,
          BaseReferences<_$AppDatabase, $WorkoutMuscleImpactsTable,
              WorkoutMuscleImpactRow>
        ),
        WorkoutMuscleImpactRow,
        PrefetchHooks Function()>;
typedef $$WorkoutRegionImpactsTableCreateCompanionBuilder
    = WorkoutRegionImpactsCompanion Function({
  required String id,
  required String sessionId,
  required MuscleRegion region,
  required double rawScore,
  required double normalizedScore,
  Value<int> rowid,
});
typedef $$WorkoutRegionImpactsTableUpdateCompanionBuilder
    = WorkoutRegionImpactsCompanion Function({
  Value<String> id,
  Value<String> sessionId,
  Value<MuscleRegion> region,
  Value<double> rawScore,
  Value<double> normalizedScore,
  Value<int> rowid,
});

class $$WorkoutRegionImpactsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutRegionImpactsTable> {
  $$WorkoutRegionImpactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MuscleRegion, MuscleRegion, String>
      get region => $composableBuilder(
          column: $table.region,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get rawScore => $composableBuilder(
      column: $table.rawScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get normalizedScore => $composableBuilder(
      column: $table.normalizedScore,
      builder: (column) => ColumnFilters(column));
}

class $$WorkoutRegionImpactsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutRegionImpactsTable> {
  $$WorkoutRegionImpactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rawScore => $composableBuilder(
      column: $table.rawScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get normalizedScore => $composableBuilder(
      column: $table.normalizedScore,
      builder: (column) => ColumnOrderings(column));
}

class $$WorkoutRegionImpactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutRegionImpactsTable> {
  $$WorkoutRegionImpactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MuscleRegion, String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<double> get rawScore =>
      $composableBuilder(column: $table.rawScore, builder: (column) => column);

  GeneratedColumn<double> get normalizedScore => $composableBuilder(
      column: $table.normalizedScore, builder: (column) => column);
}

class $$WorkoutRegionImpactsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutRegionImpactsTable,
    WorkoutRegionImpactRow,
    $$WorkoutRegionImpactsTableFilterComposer,
    $$WorkoutRegionImpactsTableOrderingComposer,
    $$WorkoutRegionImpactsTableAnnotationComposer,
    $$WorkoutRegionImpactsTableCreateCompanionBuilder,
    $$WorkoutRegionImpactsTableUpdateCompanionBuilder,
    (
      WorkoutRegionImpactRow,
      BaseReferences<_$AppDatabase, $WorkoutRegionImpactsTable,
          WorkoutRegionImpactRow>
    ),
    WorkoutRegionImpactRow,
    PrefetchHooks Function()> {
  $$WorkoutRegionImpactsTableTableManager(
      _$AppDatabase db, $WorkoutRegionImpactsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutRegionImpactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutRegionImpactsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutRegionImpactsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sessionId = const Value.absent(),
            Value<MuscleRegion> region = const Value.absent(),
            Value<double> rawScore = const Value.absent(),
            Value<double> normalizedScore = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutRegionImpactsCompanion(
            id: id,
            sessionId: sessionId,
            region: region,
            rawScore: rawScore,
            normalizedScore: normalizedScore,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sessionId,
            required MuscleRegion region,
            required double rawScore,
            required double normalizedScore,
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutRegionImpactsCompanion.insert(
            id: id,
            sessionId: sessionId,
            region: region,
            rawScore: rawScore,
            normalizedScore: normalizedScore,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorkoutRegionImpactsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $WorkoutRegionImpactsTable,
        WorkoutRegionImpactRow,
        $$WorkoutRegionImpactsTableFilterComposer,
        $$WorkoutRegionImpactsTableOrderingComposer,
        $$WorkoutRegionImpactsTableAnnotationComposer,
        $$WorkoutRegionImpactsTableCreateCompanionBuilder,
        $$WorkoutRegionImpactsTableUpdateCompanionBuilder,
        (
          WorkoutRegionImpactRow,
          BaseReferences<_$AppDatabase, $WorkoutRegionImpactsTable,
              WorkoutRegionImpactRow>
        ),
        WorkoutRegionImpactRow,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$WorkoutSessionsTableTableManager get workoutSessions =>
      $$WorkoutSessionsTableTableManager(_db, _db.workoutSessions);
  $$WorkoutExercisesTableTableManager get workoutExercises =>
      $$WorkoutExercisesTableTableManager(_db, _db.workoutExercises);
  $$WorkoutSetsTableTableManager get workoutSets =>
      $$WorkoutSetsTableTableManager(_db, _db.workoutSets);
  $$RestTimerStatesTableTableManager get restTimerStates =>
      $$RestTimerStatesTableTableManager(_db, _db.restTimerStates);
  $$ExerciseMuscleTargetsTableTableManager get exerciseMuscleTargets =>
      $$ExerciseMuscleTargetsTableTableManager(_db, _db.exerciseMuscleTargets);
  $$WorkoutMuscleImpactsTableTableManager get workoutMuscleImpacts =>
      $$WorkoutMuscleImpactsTableTableManager(_db, _db.workoutMuscleImpacts);
  $$WorkoutRegionImpactsTableTableManager get workoutRegionImpacts =>
      $$WorkoutRegionImpactsTableTableManager(_db, _db.workoutRegionImpacts);
}
