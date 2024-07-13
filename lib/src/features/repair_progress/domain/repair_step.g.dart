// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RepairStepImpl _$$RepairStepImplFromJson(Map<String, dynamic> json) =>
    _$RepairStepImpl(
      idx: json['idx'] as String,
      name: json['name'] as String,
      textDescription: json['text_description'] as String?,
      audioDescription:
          const FileConverter().fromJson(json['audio_description'] as String?),
      status: $enumDecode(_$RepairStepStatusEnumMap, json['status']),
      report: json['report'] == null
          ? null
          : RepairStepReport.fromJson(json['report'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RepairStepImplToJson(_$RepairStepImpl instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'name': instance.name,
      'text_description': instance.textDescription,
      'audio_description':
          const FileConverter().toJson(instance.audioDescription),
      'status': _$RepairStepStatusEnumMap[instance.status]!,
      'report': instance.report,
    };

const _$RepairStepStatusEnumMap = {
  RepairStepStatus.PENDING: 'pending',
  RepairStepStatus.IN_PROGRESS: 'in_progress',
  RepairStepStatus.COMPLETE: 'complete',
  RepairStepStatus.CANCELLED: 'cancelled',
};
